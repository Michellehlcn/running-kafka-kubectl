import * as cdk from 'aws-cdk-lib';
import { SubnetType } from 'aws-cdk-lib/aws-ec2';
import { EngineVersion } from 'aws-cdk-lib/aws-opensearchservice';
import { Construct } from 'constructs';
// import * as sqs from 'aws-cdk-lib/aws-sqs';

const allowedIpAddresses = ['56.644.232.323/32']

export class CdkStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const vpc = new cdk.aws_ec2.Vpc(this, 'sample-rds', {
      maxAzs: 3,
      vpcName: 'sample-rds',
      subnetConfiguration: [
        {
        name: 'public',
        subnetType: cdk.aws_ec2.SubnetType.PUBLIC,
        }
      ]
    })

    // Create a security group for the serverless application
    const serverlessSecurityGroup = new cdk.aws_ec2.SecurityGroup(this, "sample-rds-security-group" , {
      vpc: vpc, 
      securityGroupName: "sample-rds-security-group",
      description: "Security group for the serverless application",
    })

    const rdsSecurityGroup = new cdk.aws_ec2.SecurityGroup(this, "sample-rds-db-security-group" , {
      vpc: vpc,
      securityGroupName: "sample-rds-db-security-group",
      description: "Security group for the RDS database",
    })

    // allow connections from specific IP addresses
    allowedIpAddresses.forEach(ip => {
      rdsSecurityGroup.addIngressRule(cdk.aws_ec2.Peer.ipv4(ip), cdk.aws_ec2.Port.tcp(5432), "Allow PostgreSQl access from specific IP addresses")
    })

    // Allow lambda security groupu to access the RDS
    rdsSecurityGroup.addIngressRule(serverlessSecurityGroup, cdk.aws_ec2.Port.tcp(5432), "Allow PostgreSQl access from Lambda")

    // Specific engine version
    const EngineVersion = cdk.aws_rds.AuroraPostgresEngineVersion.VER_16_3 

    // Create the writer and reader instances for the AUrora Cluster
    const writerInstance = cdk.aws_rds.ClusterInstance.provisioned('writer-instance',
      {
        instanceType: cdk.aws_ec2.InstanceType.of(cdk.aws_ec2.InstanceClass.BURSTABLE4_GRAVITON, cdk.aws_ec2.InstanceSize.MEDIUM),
        instanceIdentifier: 'writer-instance',
      }
    )

    // The code that defines your stack goes here

    // example resource
    // const queue = new sqs.Queue(this, 'CdkQueue', {
    //   visibilityTimeout: cdk.Duration.seconds(300)
    // });
  }
}
