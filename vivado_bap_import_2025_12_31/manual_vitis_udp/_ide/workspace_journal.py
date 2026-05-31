# 2026-06-01T10:02:54.448046600
import vitis

client = vitis.create_client()
client.set_workspace(path="vitis_ws")

platform = client.create_platform_component(name = "platform",hw_design = "$COMPONENT_LOCATION/../../EXPORT_FAST/bap_platform_no_bit.xsa",os = "standalone",cpu = "microblaze_0",domain_name = "standalone_microblaze_0",compiler = "gcc")

vitis.dispose()

