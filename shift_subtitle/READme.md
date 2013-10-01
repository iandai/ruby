## Shift Subtitle

[Ruby Learning Blog's problem 1](rubylearning.com/blog/2009/09/24/rpcfn-shift-subtitle-1)

```
645
01:31:51,210 --> 01:31:54,893
the government is implementing a new policy...

646
01:31:54,928 --> 01:31:57,664
In connection with a dramatic increase
in crime in certain neighbourhoods,
```

## Usage

On the command line:

```
gem install shift_subtitle-1.0.0.gem
shift_subtitle -p right -d 1.200 -i input.srt -o output.srt
```

* -p stands for operation, left or right
* -d stands for shift period, 1.200s
* -i input srt file
* -o outpur srt file

This command shifts everything 1.2 seconds ahead.


## NOTE

* winners of this Ruby Challenge Felipe Elias Philipp's solution https://github.com/felipeelias/shift_subtitle has mirro problem.
* run shift_subtitle --operation add --time 1.200 test/fixtures/subtitle.srt output_subtitle.srt   

input file
```
1
00:01:35,220 --> 00:01:41,894
TITANIK
```

output file
```
1
00:01:36,419 --> 00:01:43,093
TITANIK
```

result is not correct due to Time class "+" accurate to seconds.

```
1.9.3-p392 :009 > t = Time.parse("00:01:35,220")
 => 2013-10-01 00:01:35 +0900 
1.9.3-p392 :010 > t.usec
 => 220000 
1.9.3-p392 :011 > t = Time.parse("00:01:35,220") + 1.200
 => 2013-10-01 00:01:36 +0900 
1.9.3-p392 :012 > t.usec
 => 419999 
```