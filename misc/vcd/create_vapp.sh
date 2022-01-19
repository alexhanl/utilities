# vcd login session list chrome
vcd login wdc-vcd04.oc.vmware.com wdc-vcd04-apac-se-sandbox-t liangh --session-id 2f4bd4f0c5cd4aa1b4c1b050230d88fc
# vcd vapp create -c 'Global - GSS CNA - Hands-on Labs' -t 'vSphere with Tanzu 7.0 U3 (w/NSX ALB)' '[liangh] tanzu test'
# vcd vapp shutdown -y '[liangh] tanzu test'
# vcd vapp delete  '[liangh] tanzu test' --yes --force

# export vapp_name='liangh-tkg'
export vapp_name='liangh-tkgs-u3'

vcd vm update $vapp_name esx-01a --cpu 12 --cores 1 --memory 98304  
vcd vm update $vapp_name esx-02a --cpu 12 --cores 1 --memory 98304  
vcd vm update $vapp_name esx-03a --cpu 12 --cores 1 --memory 98304  
vcd vm update $vapp_name esx-04a --cpu 12 --cores 1 --memory 98304

vcd vm update $vapp_name 'Main Console' --cpu 8  --cores 1 --memory 16384
