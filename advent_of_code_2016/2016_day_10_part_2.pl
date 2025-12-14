use v5.10; use strict; use warnings;

my(@bot, @bi, @output); #bot values, bot instructions
my $target = $ARGV[0] =~ /example/ ? "2,5"
           : $ARGV[0] =~ /input/   ? "17,61" : die;
while(<>){
    if( /^value (\d+) goes to bot (\d+)/ ){
        give( $1 => $2 );
    }
    elsif( /^bot (\d+)/ ){
        push @{ $bi[$1] }, $_;
        dobi($1);
    }
}

say "Answer part 2: ", eval join '*', map @$_, @output[0,1,2];

sub give {
    my($value, $bot)=@_;
    push @{ $bot[$bot] }, $value;
    dobi($bot);
}

sub dobi {
    my $bot = shift;
    while( @{ $bi[$bot] // [] }            #instructions waiting for this bot and has 2 values
       and @{ $bot[$bot] // [] } >= 2 )
    {
        my($whatL, $toL, $whatH, $toH)
          = shift( @{ $bi[$bot] } )
          =~ /bot \d+ gives low to (bot|output) (\d+) and high to (bot|output) (\d+)/;
        @{ $bot[$bot] } = sort {$a<=>$b} @{ $bot[$bot] };
        my $low  = shift @{ $bot[$bot] };
        my $high = pop   @{ $bot[$bot] };
        give($low  => $toL) if $whatL eq 'bot';
        give($high => $toH) if $whatH eq 'bot';
        push @{ $output[$toL] }, $low  if $whatL eq 'output';
        push @{ $output[$toH] }, $high if $whatH eq 'output';
        say "Answer part 1: $bot" if "$low,$high" eq $target;
    }
}

# perl 2016_day_10_part_2.pl 2016_day_10_example.txt
# Answer part 1: 2
# Answer part 2: 30

# perl 2016_day_10_part_2.pl 2016_day_10_input.txt
# Answer part 1: 157
# Answer part 2: 1085
