## shift_subtitle

{Ruby Learning Blog's problem}[rubylearning.com/blog/2009/09/24/rpcfn-shift-subtitle-1]

shift time of subtitle such as:

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
	$ gem install shift_subtitle-1.0.0.gem
  $ shift_subtitle -p right -d 1.200 -i input.srt -o output.srt

-p stands for operation, left or right

-d stands for shift period, 1.200s

-i input srt file

-o outpur srt file

This command shifts everything 1.2 seconds ahead.

You can use 'left' for shift everything X seconds back.
