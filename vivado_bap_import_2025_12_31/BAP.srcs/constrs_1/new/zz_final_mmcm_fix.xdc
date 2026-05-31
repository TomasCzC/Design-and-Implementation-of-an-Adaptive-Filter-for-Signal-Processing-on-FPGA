# Emergency MMCM VCO fix

foreach mmcm [get_cells -hier -quiet -filter {REF_NAME == MMCME2_ADV}] {
    set period [get_property CLKIN1_PERIOD $mmcm]
    set mult   [get_property CLKFBOUT_MULT_F $mmcm]
    set divclk [get_property DIVCLK_DIVIDE $mmcm]

    if {$period ne "" && $mult ne "" && $divclk ne ""} {
        set fvco [expr {1000.0 * double($mult) / (double($period) * double($divclk))}]

        if {$fvco < 600.0} {
            puts "Fixing MMCM $mmcm, FVCO was $fvco MHz"

            set new_mult [expr {double($mult) * 2.0}]
            set_property CLKFBOUT_MULT_F $new_mult $mmcm

            foreach prop {CLKOUT0_DIVIDE_F CLKOUT1_DIVIDE CLKOUT2_DIVIDE CLKOUT3_DIVIDE CLKOUT4_DIVIDE CLKOUT5_DIVIDE CLKOUT6_DIVIDE} {
                if {[catch {set old [get_property $prop $mmcm]}] == 0} {
                    if {$old ne ""} {
                        set new [expr {double($old) * 2.0}]
                        puts "  $prop: $old -> $new"
                        set_property $prop $new $mmcm
                    }
                }
            }
        }
    }
}

