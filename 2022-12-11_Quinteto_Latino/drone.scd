Quarks.gui;

SCLOrkSynths.gui

(
Ndef(\test,
	Pbind(
		\instrument, \FMRhodes1,
		\midinote, Prand([43, 43+7], inf) + [0, 7],
		\ctranspose, Pwrand([0, -12], [0.8, 0.2], inf),
		\dur, Pwhite(2, 8, inf),
		\amp, Pwhite(-6, -12, inf).dbamp,
		\legato, 1.9,
		\lfoFreq, Pwhite(0.1, 0.2),
		\att, [1, 0.5, 0.2]
		// \lfoDepth, Pwhite(0.015, 0.03)
	)
);
)
Ndef(\test2).clear(5)

(
Ndef(\test3,
	Pbind(
		\instrument, \FMRhodes1,
		\midinote, Prand([43, 43+7], inf) + [0, 7],
		\ctranspose, Pwrand([-12, -24], [0.8, 0.2], inf),
		\dur, Pseq([1, 3], inf),
		\amp, Pwhite(-6, -8, inf).dbamp,
		\legato, 1,
		\lfoFreq, Pwhite(0.01, 0.2),
		\att, [0.001, 0.5, 0.002]
		// \lfoDepth, Pwhite(0.015, 0.03)
	)
);
)

(
Ndef(\test2,
	Pbind(
		\instrument, \FMRhodes2,
		\midinote, Pseq([43, 45], 1),
		\ctranspose, Pwrand([24, 19], [0.8, 0.2], inf),
		\dur, Pseq([1, 3], inf), //Pwhite(1, 1.1, inf),
		\amp, Pwhite(-8, -19, inf).dbamp,
		\legato, 0.6,
		\lfoFreq, Pwhite(0.01, 0.1),
		\att, [1, 0.05, 0.02],
		\rel, 15
		// \lfoDepth, Pwhite(0.015, 0.03)
	)
);
)

(
Ndef(\test4,
	Pbind(
		\instrument, \FMRhodes2,
		\midinote, Prand([43, 45, 50, 57], 6) + [12, 24],
		\ctranspose, Pwrand([24, 12], [0.8, 0.2], inf),
		\dur, Pseq([1/2, 1/4], 10), //Pwhite(1, 1.1, inf),
		\amp, Pwhite(-3, -5, inf).dbamp * Pwhite(0, 1),
		\legato, 0.1,
		// \lfoFreq, Pwhite(0.01, 0.1),
		\att, [0, 0.05, 0.02],
		\rel, 5
		// \lfoDepth, Pwhite(0.015, 0.03)
	)
);
)

(
Ndef(\test4,
	Pbind(
		\instrument, \FMRhodes1,
		\midinote, Pseq([43-7, 45, 50, 57], 40) + [12, 24],
		// \ctranspose, Pwrand([24, 12], [0.5, 0.5], inf),
		\ctranspose, Pseq([-12, -5, 0, 4, 7, 12, 16], inf),
		\dur, Pseq([1/8, 1/4], inf), //Pwhite(1, 1.1, inf),
		\amp, Pwhite(-1, -5, inf).dbamp * Pwhite(0, 1),
		\legato, 0.1,
		// \lfoFreq, Pwhite(0.01, 0.1),
		\att, [0, 0.05, 0.02],
		\rel, 1,
		\pan, Pwhite(-1, 1)
		// \lfoDepth, Pwhite(0.015, 0.03)
	)
);
)

(
Ndef(\fx).fadeTime = 10;
Ndef(\fx, {
	var snd = Ndef.ar(\test) + Ndef.ar(\test2) + Ndef.ar(\test3) + Ndef.ar(\test4);
	snd = HPF.ar(snd, LFNoise2.ar(1/[2,4,3.2]).range(30, 90));
	snd = CombC.ar(
		in: snd,
		maxdelaytime: 1.0,
		delaytime: Array.rand(4, 0.15, 0.9).round(0.125),
		decaytime: [13, 4, 16]
	);
	snd = Normalizer.ar(snd, 0.8);
	snd = Clip.ar(snd, -0.12, 0.12) * LFPulse.ar([10, 23, 40]).range(0.38, 1);
	snd = Splay.ar(snd);
	snd = FreeVerb.ar(snd, 0.5, 0.9);

	snd = Limiter.ar(snd);
}).play;
)

Ndef(\fx).stop(10)