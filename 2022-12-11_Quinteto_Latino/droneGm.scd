Quarks.gui;

SCLOrkSynths.gui

p = Ndef(\tempo).proxyspace.makeTempoClock(60/60).quant_(1.0);

p.clock.tempo = 100/60;

Ndef.clear
(
Ndef(\gm,
	Pbind(
		\instrument, \FMRhodes1,
		\note, [0, 3, 7],
		\ctranspose, -5 + Prand([0, -12, 12], inf),
		\dur, Pwhite(3, 6, inf),
		\amp, Pwhite(-6, -12, inf).dbamp,
		\legato, 0.7,
		\lfoFreq, Pwhite(0.1, 0.2),
		\att, [1, 0.5, 0.2]
		// \lfoDepth, Pwhite(0.015, 0.03)
	)
).quant_(3);
)

(

Ndef(\gm,
	Pbind(
		\instrument, \FMRhodes1,
		\note,Pseq([
			Pseq([-12, Pn([0, 3, 7], 2)], 2),
			Pseq([-5, Pn([-1, 2, 5], 2)], 2),

		], inf),
		\ctranspose, -5 + Pseq([[0, -12], Prand([[0, 12, 12].scramble, [0, 12, 0].scramble], 2)], inf),
		\dur, 1,
		\amp, Pwhite(-9, -12, inf).dbamp,
		\legato, Pwhite(0.4, 0.57),
		\lfoFreq, Pwhite(0.1, 0.2),
		\att, Pseq([0.001, 0.05, 0.2], inf)
		// \lfoDepth, Pwhite(0.015, 0.03)
	)
).quant_(3);
)

(
Ndef(\gm,
	Pbind(
		\instrument, \FMRhodes1,
		\note,Pseq([
			// Pseq([-12, Pn([0, 3, 7], 2)], 2),
			Pseq([-7, Pn([-4, 0, 3], 2)], 2),

		], inf),
		\ctranspose, -5 + Pseq([[0, -12], Prand([[0, 12, 12].scramble, [0, 12, 0].scramble], 2)], inf),
		\dur, Pseq([1, 1, 1], inf) * 1,
		\amp, Pwhite(-9, -12, inf).dbamp,
		\legato, Pwhite(0.4, 0.57),
		\lfoFreq, Pwhite(0.1, 0.2),
		\att, Pseq([0.001, 0.05, 0.2], inf)
		// \lfoDepth, Pwhite(0.015, 0.03)
	)
).quant_(3);
)

(
Ndef(\gm,
	Pbind(
		\instrument, \FMRhodes1,
		\midinote,Pseq([
			Pseq([57, Pn([57, 58, 61, 64, 67], 2)], 2),
		], inf),
		\ctranspose, Pseq([[0, -12], Prand([[0, 12, -12].scramble, [0, 12, 0].scramble], 2)], inf),
		\dur, Pseq([1, 1, 1], inf) * 1,
		\amp, Pwhite(-9, -12, inf).dbamp,
		\legato, Pwhite(0.4, 0.57),
		\lfoFreq, Pwhite(0.1, 0.2),
		\att, Pseq([0.001, 0.05, 0.2], inf)
		// \lfoDepth, Pwhite(0.015, 0.03)
	)
).quant_(3);
)


Ndef(\gm).clear(5)


(
Ndef(\mel,
	Pbind(
		\instrument, \FMRhodes2,
		\midinote, Pseq([
			63, 62, 62, 66, 66, 69, 69, 72, 72, 74, 74,
			62, 63, 62, 62, 67, 67, 70, 70, 70, 70, 70, \rest, \rest
		], [2, 2].choose),
		\ctranspose, Pwrand([-12, -24], [0.8, 0.2], inf) + [0, 24, 36],
		\dur, 0.5, //Pseq([1, 3], inf),
		\amp, Pwhite(-6, -8, inf).dbamp,
		\legato, 1,
		\lfoFreq, Pwhite(0.01, 0.2),
		\att, Prand([0.001, 0.1, 0.2], inf),
		\pan, Pwhite(-1, 1.0)
		// \lfoDepth, Pwhite(0.015, 0.03)
	)
).quant_(3);
)

Ndef(\mel).clear(1)

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
		\midinote, Pseq([75, 74, 50, 57], 40) + [12, 24],
		\ctranspose, Pwrand([0, -5], [0.5, 0.5], inf),
		\ctranspose,0, // Pseq([-12, -5, 0, 4, 7, 12, 16], inf),
		\dur, Pseq([1/8, 1/4], inf), //Pwhite(1, 1.1, inf),
		\amp, Pwhite(-1, -5, inf).dbamp * Pwhite(0, 1),
		\legato, 0.1,
		// \lfoFreq, Pwhite(0.01, 0.1),
		\att, [0, 0.05, 0.02],
		\rel, 1,
		\pan, Pwhite(-1, 1)
		// \lfoDepth, Pwhite(0.015, 0.03)
	)
).play;
)

(
Ndef(\fx).fadeTime = 10;
Ndef(\fx, {
	var snd = Ndef.ar(\gm) + Ndef.ar(\mel);// + Ndef.ar(\test3) + Ndef.ar(\test4);
	// snd = HPF.ar(snd, LFNoise2.ar(1/[2,4,3.2]).range(30, 90));
	snd = snd + CombC.ar(
		in: snd,
		maxdelaytime: 1.0,
		delaytime: Array.rand(4, 0.15, 0.9).round(0.125),
		decaytime: [13, 4, 16],
		mul: 0.5
	);
	// snd = Normalizer.ar(snd, 0.45);
	snd = Clip.ar(snd, -0.52, 0.52);// * LFPulse.ar([1, 2.1, 4.0]).range(0.38, 1);
	snd = Splay.ar(snd);
	snd = FreeVerb.ar(snd, 0.35, 0.5);

	snd = Limiter.ar(snd);
}).play;
)

Ndef(\fx).stop(10)