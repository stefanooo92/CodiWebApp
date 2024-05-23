# diagram.py
from diagrams import Cluster, Diagram
from diagrams.azure.network import ApplicationGateway
from diagrams.azure.network import LoadBalancers
from diagrams.azure.compute import ContainerInstances
from diagrams.azure.network import NetworkSecurityGroupsClassic
from diagrams.azure.network import PublicIpAddresses
from diagrams.azure.web import Search
from diagrams.azure.security import KeyVaults
from diagrams.azure.network import Firewall


with Diagram("WebApp Architecture", show=False):
    INTERNET = Search("Public Internet")

    with Cluster("Azure Virtual Network"):
        with Cluster("App Gateway Subnet"):
            PIP = PublicIpAddresses("Public IP")
            with Cluster (""):
                KV = KeyVaults("Key Vault SSL Certificate")
                APGTW = ApplicationGateway("Application Gateway")
                FW = Firewall("WAF Policy")
        with Cluster("Container Apps Subnet"):
            NSG = NetworkSecurityGroupsClassic("Nsg") 
            LB = LoadBalancers("ILB")
            with Cluster("Container Apps Environment"):
                CA1 = ContainerInstances("App Replica 1")
                CA2 = ContainerInstances("App Replica 2")
                CA3 = ContainerInstances("App Replica 3")



    INTERNET >> PIP >> APGTW >> NSG >> LB >> [CA1, CA2, CA3]
    