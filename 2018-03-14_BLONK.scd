

Ndef(\in).play;
Ndef(\in, { SoundIn.ar([0, 1]) });


Ndef(\verb, { FreeVerb.ar(Ndef.ar(\in), 0.6, 0.6, 0.4) });

Ndef(\verb).play;

Ndef(\verb).fadeTime = 1

(
Ndef(\verb, {
	var snd, in, snd2;
	in = Ndef.ar(\in);
	snd = in + CombC.ar(
		in: in,
		maxdelaytime: 2.5,
		delaytime: MouseX.kr(1, 1.1) * [0.016, 0.017, 0.015, 0.02],
		decaytime: [1, 2, 3],
		mul: 4
	);
	snd = [LFPulse, LFSaw, SinOsc, SinOsc].choose.ar(
		freq: LFNoise2.kr(2).range(1/3, 8),
		mul: 0.9) * snd;
	snd = PitchShift.ar(
		in: snd,
		windowSize: 0.2,
		pitchRatio: [LFSaw, LFPulse, LFNoise0].choose.ar(1/[2, 3, 1]),
		pitchDispersion:0.8,
		timeDispersion: 0.1
	) + snd;
	snd2 = HPF.ar(snd, LFNoise2.ar(1/[1, 2, 3]).range(1000, 6800));
	snd = FreeVerb.ar(snd, 0.7, 0.8, 0.4);
	snd = Splay.ar(snd+snd2);
	snd = Limiter.ar(snd)

});
)

Ndef.clear
