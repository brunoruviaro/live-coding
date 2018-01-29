a = Scale.major.tuning_(\just);

a.semitones;
a.ratios

(
f.stop;
f = {
	30.do({ arg i;
	Ndef(\chord, { |freq=200, amp=0.42|
		var env, snd, freqs;
		freqs = freq * a.ratios * [1, 1, 1, 1, 2].scramble;
		env = SinOsc.kr(1/[1,2, 3, 4, 5, 6].scramble).range(0.1, 1) * amp;
			// env = LFTri.ar([1, 2, 3].scramble).range(0.1, 1) * amp;
			snd = SinOsc.ar(freqs * [1, 1.01,], mul: env);
		snd = Splay.ar(snd);
	});
		i.postln;
	rrand(4, 5).wait;
	})
}.fork;
)

f.stop;

Ndef(\chord).play(fadeTime: 10);
Ndef(\chord).fadeTime = 4;
Ndef(\chord).clear(10);

(
Ndef(\chant, { arg freq=1000;
	var list, note, snd, snd2;
	list = [250, 500, 800, 900, 1000, 1000, 1000, 1100, 1200, 1200];
	note = Demand.kr(TDuty.kr(Dwhite(1/2, 1)), 0, Drand(list, inf));
	note = note + SinOsc.kr(4).range(-10, 10);
	snd = LFPulse.ar(note * [1, 1.01, 1.001, 1.002]);
	snd = snd * LFPulse.ar(LFNoise2.kr(1/4).range(1/2, 5.0) + MouseX.kr(0.3, 1.5), width: Rand(0.12, 0.5));
	snd = LPF.ar(snd, LFNoise0.kr(1).range(1000, 4000));
	snd2 = PitchShift.ar(snd, 0.2, LFNoise0.kr(1.3).range(0.9, 1.5).round(0.1), Rand(0, 0.2));
	snd = snd + CombN.ar(snd2, 1, [0.35, 0.75], 1);
	snd = snd + FreeVerb.ar(snd, 0.6, 0.7);
	snd = Splay.ar(snd) * SinOsc.kr(1/5).range(0.14, 0.31);
})
)

f.reset.play;

Ndef(\chant).play(fadeTime: 10);

Ndef.clear(30);
