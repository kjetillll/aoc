object Main {
  def main(args: Array[String]): Unit =
     println( "Answer: " + io.Source.fromFile(args(0)).getLines.map(l=>tall(l.split("\\D+").map(_.toLong))).sum )
}

def tall(ns:Array[Long]):Long = {
  if ( ns.size == 2 ) return if ( ns(0)==ns(1) ) ns(0) else 0
  val sum = tall( Array( ns(0), ns(1) + ns(2))                             ++ ns.drop(3) ); if( sum > 0 ) return sum
  val mul = tall( Array( ns(0), ns(1) * ns(2))                             ++ ns.drop(3) ); if( mul > 0 ) return mul
  val con = tall( Array( ns(0), (ns(1).toString + ns(2).toString).toLong ) ++ ns.drop(3) );               return con
}

//Run:
//time scala 2024_day_07_part_2.scala -- 2024_day_07_input.txt    # 1.76 sec, scala3
//Answer: 223472064194845
