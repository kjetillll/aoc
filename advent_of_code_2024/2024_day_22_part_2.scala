import scala.collection.mutable._
def main(args: Array[String]): Unit = {
  val seqsum = Map[String,Long]()
  io.Source.fromFile(args(0)).getLines.foreach { line =>
    var secret = line.toLong
    val diff = Queue[Long]()
    val seen = Set[String]()
    var prev = -999L
    for( n <- 1 to 2000) {

      val ones = secret % 10

      if( n > 1 ) diff.enqueue( ones - prev )
      prev = ones

      if( diff.size == 4 ){
        val seq = diff.mkString(",")
        if( ! seen.contains( seq ) ){
          seqsum( seq ) = seqsum.getOrElse( seq, 0L ) + ones
          seen += seq
        }
        diff.dequeue
      }

      secret ^= secret * 64;   secret %= 16777216
      secret ^= secret / 32;   secret %= 16777216
      secret ^= secret * 2048; secret %= 16777216

    } // 1 to 2000
  } // getLines
  println( "Answer: " + seqsum.values.max )
}

//Answer: 1998
//Run scala3:
//time scala 2024_day_22_part_2.scala -- 2024_day_22_example2.txt  # Answer: 23    0.58 sec
//time scala 2024_day_22_part_2.scala -- 2024_day_22_input.txt     # Answer: 1998  2.09 sec
