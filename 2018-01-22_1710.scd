a = Scale.major.tuning_(\just);
a.semitones;

Ndef(\chord).play;
Ndef(\chord).fadeTime = 4;

Ndef(\chord, { SinOsc.ar([110, 111], mul: XLine.kr(0.001, 1, 20)) }).play;


(
Ndef(\chord, { arg freq=110, amp=0.2;
	var notes, env, env2, snd;
	notes = freq.cpsmidi + a.semitones + [0, 0, 0, 0, 0, 12, 24].scramble;
	env2 =  Saw.ar(1/[1,2,3,4,5,6]).range(0.0, 0.5);
	env = SinOsc.ar(1/[1,2,3,4,5,9]).range(0.1, 0.35);
	env = Select.ar(LFPulse.ar(1/4), [env, env2]);
	snd = SinOsc.ar(freq: notes.midicps * [1, 1.01, 1.05, 2], mul: env);
	Splay.ar(Limiter.ar(snd, 0.9));
})
)

Ndef(\mel).play;
(
Ndef(\mel, { arg freq=1000, amp=0.1;
	var snd = SinOsc.ar(
		freq: freq * [1, 1.01, 1.015, 1.016, 1.017] * SinOsc.ar(1).range(0.9, 1.02),
		mul: amp * LFPulse.ar(MouseX.kr(1/4, 3))
	);
	snd = Splay.ar(snd);
}
)
)

(
Ndef(\ps, {
	var snd = PitchShift.ar(Ndef(\mel), pitchRatio: [1,2,1.5]) * 0.3;
	snd = snd + CombC.ar(snd, 1, rrand(0.2, 0.9), 2);
	snd = snd.distort;
	snd = Splay.ar(snd)
}).play;
)

Ndef(\ps).fadeTime =3;


(
f.stop;
f = {
	25.do{ arg i;
		Ndef(\mel).set(\freq, 1000 + [100, -100, 0, 0, 0, 200, 500, -100, -200, -200].choose * [1/2, 1/2, 1, 1/2]);
		rrand(0.14, 5).wait;
		i.postln;

	}
}.fork;
)


Ndef.clear(30);

(
Ndef(\rev, {
	var in = In.ar(0);
	var snd = FreeVerb.ar(in, 0.5, 0.7);
	snd = ReplaceOut.ar(0, snd);
}).play;
)
	
