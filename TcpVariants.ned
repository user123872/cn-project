

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.StandardHost;
import inet.node.inet.Router;
import inet.linklayer.ethernet.EthernetInterface;
import ned.DatarateChannel;
package tcp_con_control_analysis;
network TcpVariants
{
    parameters:
        @display("bgb=613,326");
        // Statistics for throughput, delay, and packet loss
        @statistic[throughput](title="TCP Throughput"; unit="bps"; record=avg,vector);
        @statistic[endToEndDelay](title="End-to-End Delay"; unit="s"; record=avg,vector);
        @statistic[packetLoss](title="Packet Loss Rate"; unit="packets"; record=sum,vector);
        @statistic[cwnd](title="Congestion Window Size"; unit="bytes"; record=avg,vector);
        @statistic[rtt](title="Round-Trip Time"; unit="s"; record=avg,vector);
    submodules:
        configurator: Ipv4NetworkConfigurator {
            @display("p=300,50");
        }
        sender: StandardHost {
            @display("p=98,151");
        }
        router: Router {
            @display("p=300,151");
        }
        receiver: StandardHost {
            @display("p=500,151");
        }
        // Background traffic generator to simulate network load
        trafficGen: StandardHost {
            @display("p=300,239");
        }
    connections allowunconnected:
        sender.ethg++ <--> DatarateChannel { delay = 10ms; datarate = 100Mbps; } <--> router.ethg++;
        router.ethg++ <--> DatarateChannel { delay = 10ms; datarate = 100Mbps; } <--> receiver.ethg++;
        trafficGen.ethg++ <--> DatarateChannel { delay = 10ms; datarate = 100Mbps; } <--> router.ethg++;
}