import org.apache.flink.api.common.serialization.SimpleStringSchema
import org.apache.flink.streaming.api.scala._
import org.apache.flink.streaming.connectors.kafka.{FlinkKafkaConsumer, FlinkKafkaProducer}
import org.apache.flink.streaming.util.serialization.KeyedSerializationSchemaWrapper
import java.util.Properties

object TransactionProcessor {
  def main(args: Array[String]): Unit = {
    val env = StreamExecutionEnvironment.getExecutionEnvironment

    val kafkaConsumerProperties = new Properties()
    kafkaConsumerProperties.setProperty("bootstrap.servers", "localhost:9092")
    kafkaConsumerProperties.setProperty("group.id", "transaction-consumer")

    val transactionStream = env
      .addSource(new FlinkKafkaConsumer[String](
        "transactions",
        new SimpleStringSchema(),
        kafkaConsumerProperties
      ))

    val processedStream = transactionStream.map { transaction =>
      // Process the transaction data (e.g., JSON parsing, validation, etc.)
      // Here, we'll just simulate some processing
      s"Processed transaction: $transaction"
    }

    val kafkaProducerProperties = new Properties()
    kafkaProducerProperties.setProperty("bootstrap.servers", "localhost:9092")

    processedStream.addSink(new FlinkKafkaProducer[String](
      "processed-transactions",
      new KeyedSerializationSchemaWrapper(new SimpleStringSchema()),
      kafkaProducerProperties,
      FlinkKafkaProducer.Semantic.AT_LEAST_ONCE
    ))

    env.execute("Transaction Processing Job")
  }
}
