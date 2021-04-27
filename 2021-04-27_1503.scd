(
Ndef(\wow).fadeTime = 1;
Ndef(\wow, {
	var snd, snd2;
	// snd = SinOsc.ar(SinOsc.ar(1).range(140, 550));
	snd = PMOsc.ar(
		carfreq: Demand.kr(
			trig: Impulse.kr(1/4),
			reset: 0,
			demandUGens: Dseq([50, 100, 400, 500, 440], inf)
		) * LFSaw.ar(1/2).range(1, 4).round(1),
		modfreq: LFPulse.ar(1).range(300, 900),
		pmindex: LFSaw.ar(1/4).range(8, 2)
		);
	snd = RLPF.ar(snd, SinOsc.kr(1).range(200, 1000), LFNoise0.kr(3).range(0.2, 0.9)); 
	snd = snd * LFPulse.ar(freq: [2, 3] * LFNoise2.ar(1).range(1/2, 2), width: 0.5).range(0.00, 1);
	snd = SinOsc.ar(freq: 0, phase: snd.fold(-0.75, 0.95));
	snd = snd + (
		CombC.ar(
			in: PitchShift.ar(snd, 0.2, [1.5, 2]) * Compander.ar(snd, snd, 0.003, 2, 1, 0.01, 0.2),
			maxdelaytime: 1,
			delaytime: LFPulse.ar(1/3).range(0.12, 0.3),
			decaytime: 5,
			mul: SinOsc.ar(1/3).range(0.3, 2)
		)
	);
	snd2 = LFSaw.ar(snd.range(50, 1000) * LFNoise0.ar([1, 5, 3]).range(1, 10).round(1));
	snd = FreeVerb.ar(
		in: (snd2 * LFNoise2.ar(0.0001, 1)) + (snd * SinOsc.ar(1/15).range(0.1, 1)),
		mix: 0.2,
		room: 0.7, 
		damp: 0.5
	); 
	snd = Splay.ar(snd);
	snd = Limiter.ar(snd);
}).play;
)

Ndef(\wow).clear(10);
