


(
Window.closeAll;
w = Window.new("t", Window.screenBounds).front.fullScreen;
w.background = Color.black;
t = StaticText.new(w, Window.screenBounds);
t.string = "\"Love me\".do({ |i, u| (i++u).post });";
t.stringColor = Color.white;
t.align = \center;
t.font = Font("DejaVu Sans Mono", 32);
)

w.background = Color.gray(0, 1);
t.stringColor = Color.green;

(
~fade = {arg seconds, target; //0=black, 1=white
	var steps = 200;
	var from, to;

	if(target==0, { from=1.0; to=0 }, { from=0; to=1.0 });

	{
		steps.do({ arg i;
			var alpha = i.linlin(0, steps, from, to);
			{
				w.background = Color.gray(0, alpha);
				t.stringColor = Color.gray(1, alpha);

			}.defer;
			(seconds/steps).wait;
		});

		"done fading".postln;
	}.fork;
};
)

t.background = Color.black;
~fade.value(10, 1);


