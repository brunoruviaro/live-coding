Ndef.clear(10)


b = Buffer.read(s, "".resolveRelative ++ "QL_Brasileirinho_111622.wav");

b.play



// nice alternate intro, sparse take on the intro
(
Ndef(\a).fadeTime = 5;
Ndef(\a, {
	var snd;
	var win;
	var sample = b;
	var trig = Impulse.ar(1 * [1, 2, 4]);

	snd = GrainBuf.ar(
		numChannels: 2,
		trigger: trig,
		dur: [7, 2, 4.3] / 10,
		sndbuf: sample,
		rate: 1 , //* Env.triangle(3).ar(gate: Impulse.ar(1/3), levelBias: 0.5).poll,
		pos:
		// 0.48
		// [0.27, 0.20, 0.15]
		LFSaw.ar(1/10).range(0, 0.15) // scan the intro over x seconds
		,
		interp: 4,
		pan: LFNoise0.ar(2).range(-0.5, 0.5),
		mul: 1
	);
	snd = Splay.ar(snd.flat);
	// snd = Normalizer.ar(snd, 0.4, 0.1);
	snd = FreeVerb.ar(snd, 0.4, 0.78);
	snd = Limiter.ar(snd)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
)


// post intro, recognizable loop
(
Ndef(\a).fadeTime = 5;
Ndef(\a, {
	var snd;
	var win;
	var sample = b;
	var trig = Impulse.ar(1/3);

	snd = GrainBuf.ar(
		numChannels: 2,
		trigger: trig,
		dur: [5, 6.3],
		sndbuf: sample,
		rate: 1, //* Env.triangle(5).ar(gate: Impulse.ar(1), levelBias: 0.5).poll,
		pos:
		0.45
		// [0.47, 0.50, 0.55]
		,
		interp: 4,
		pan: LFNoise0.ar(2).range(-0.5, 0.5),
		mul: 1
	);
	snd = Splay.ar(snd.flat);
	// snd = Normalizer.ar(snd, 0.4, 0.1);
	snd = FreeVerb.ar(snd, 0.4, 0.58);
	snd = Limiter.ar(snd)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
)



(
Ndef(\a).fadeTime = 15;
Ndef(\a, {
	var snd;
	var win;
	var sample = b;
	var trig = Impulse.ar(10);

	snd = GrainBuf.ar(
		numChannels: 2,
		trigger: trig,// * SinOsc.ar(1/3).range(1, 2),
		dur: Array.rand(4, 0.9, 1),
		sndbuf: sample,
		rate: 1 * Env.triangle(0.4).kr(gate: Dust.kr(0.4), levelBias: 1.0),// * LFPulse.ar(1/5, 0, 0.9).range([0.5, 0.25], 1),
		pos: Demand.ar(
			trig: trig,
			reset: 0,
			demandUGens: Dseq([0.22, 0.4, 0.67, 0.68], inf)
			// demandUGens: Dseq(Array.series(14, 0.01, 0.1), inf).min(0.99)
		)
		,
		interp: 4,
		pan: LFNoise0.ar(4),
		mul: 0.5
	);

	snd = Splay.ar(snd.flat);
	snd = FreeVerb.ar(snd, 0.4, 0.8);
	snd = Limiter.ar(snd, 0.7)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
)



// machine music
(
Ndef(\a).fadeTime = 0;
Ndef(\a, {
	var snd;
	var win;
	var sample = b;
	var trig = Impulse.ar(3);

	snd = GrainBuf.ar(
		numChannels: 2,
		trigger: trig,
		dur: Array.rand(4, 0.09, 0.19),
		sndbuf: sample,
		rate: [0.75, 1, 1.5],// * LFPulse.ar(1/5, 0, 0.9).range([0.5, 0.25], 1),
		pos: Demand.ar(
			trig: trig,
			reset: 0,
			// demandUGens: Dseq([0.22, 0.4, 0.67, 0.68], inf)
			// demandUGens: Dseq([0.2, 0.4, 0.7, 0.8, 0.21], inf)
			demandUGens: Dshuf(Array.series(14, 0.2, 0.01), inf)
		)
		,
		interp: 4,
		pan: LFNoise0.ar(4),
		mul: 1.5
	);

	// snd = Splay.ar(snd.flat);
	snd = FreeVerb.ar(snd, 0.4, 0.8);
	snd = Limiter.ar(snd)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
Ndef(\a).quant_(1)
)



// cluster, mid freq, occasional low transposition
(
Ndef(\a).fadeTime = 0.5;
Ndef(\a, {
	var snd;
	var win;
	var sample = b;

	snd = GrainBuf.ar(
		numChannels: 2,
		trigger: Impulse.ar([3,5]) * SinOsc.ar(1/3).range(1, 2),
		dur: Array.rand(4, 0.2, 1),
		sndbuf: sample,
		rate: [0.999, 1, 1.01] * LFPulse.ar(1/5, 0, 0.9).range([0.5, 0.25], 1),
		pos: 0.22
		,
		interp: 4,
		pan: LFNoise0.ar(4),
		mul: 1.5
	);

	snd = FreeVerb.ar(snd, 0.4, 0.7);
	snd = Limiter.ar(snd)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
)


x = {SinOsc.ar(MouseX.kr(100, 200).poll) * 0.1}.play;

x.free;

// as above, but more staccato
(
Ndef(\a).fadeTime = 5;
Ndef(\a, {
	var snd;
	var win;
	var sample = b;

	snd = GrainBuf.ar(
		numChannels: 2,
		trigger: Impulse.ar([3,5]) * SinOsc.ar(1/3).range(1, 2),
		dur: Array.rand(4, 0.07, 0.1),
		sndbuf: sample,
		rate: [0.999, 1, 1.01] * LFPulse.ar(1/5, 0, 0.9).range([0.5, 0.25], 1),
		pos: [0.22, [0.21, 0.24].choose]
		,
		interp: 4,
		pan: LFNoise0.ar(4),
		mul: 1.5
	);

	snd = snd + RHPF.ar(snd, 135 * [0, 2, 9].midiratio * 4, 0.13);
	snd = FreeVerb.ar(snd, 0.54, 0.65);
	snd = Limiter.ar(snd)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
)

// mid cluster loud
(
Ndef(\a).fadeTime = 1;
Ndef(\a, {
	var snd;
	var win;
	var sample = b;

	snd = GrainBuf.ar(
		numChannels: 2,
		trigger: Impulse.ar([3,5]) * SinOsc.ar(1/3).range(1, 2),
		dur: Array.rand(4, 0.2, 2),
		sndbuf: sample,
		rate: [0.999, 1, 1.01] * LFPulse.ar(1/5, 0, 0.9).range([0.5, 0.25], 1),
		pos: LFTri.ar(2).range(0.9, 0.95)
		,
		interp: 4,
		pan: LFNoise0.ar(4),
		mul: SinOsc.ar(1/[4,3,5]).range(0.5, 2)
	);

	snd = CombC.ar(
		in: snd,
		maxdelaytime: 1.0,
		delaytime: [0.3, 0.6, 0.7],// * LFPulse.ar(1/4).range(1, 2),
		decaytime: [4,5],
		mul: SinOsc.ar(1/[4,3]).range(0.3, 1.0)
	);
	snd = Splay.ar(snd);
	snd = FreeVerb.ar(snd, 0.4, 0.5, 0.3, 2);
	snd = Limiter.ar(snd)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
)

// low, thick clouds
(
Ndef(\a).fadeTime = 15;
Ndef(\a, {
	var snd;
	var win;
	var sample = b;

	snd = GrainBuf.ar(
		numChannels: 2,
		trigger: Impulse.ar(3) * SinOsc.ar(1/5).range(1/3, 2),
		dur: Array.rand(4, 1/2, 5),
		sndbuf: sample,
		rate: LFPulse.ar(2).range(1/4, 1/2) * 1.neg,
		pos: LFTri.ar(1/3).range(0.04, 0.8)
		,
		interp: 4,
		pan: LFNoise0.ar(4),
		mul: SinOsc.ar(1/[4,3,1]).range(0.0, 0.5)
	);

	snd = CombC.ar(
		in: snd,
		maxdelaytime: 1.0,
		delaytime: [0.3, 0.4, 0.33] / 0.9, //LFPulse.ar(1).range(3, 4.3),
		decaytime: [4,2.5],
		mul: SinOsc.ar(1/[4,3]).range(0.3, 1.0)
	);
	snd = RLPF.ar(snd, [440, 880, 1220] *LFNoise2.ar(1/3).range(1, 2), 0.24);
	snd = Splay.ar(snd);
	snd = FreeVerb.ar(snd, 0.4, 0.5, 0.3, 1);
	snd = Limiter.ar(snd)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
)


// distorted, slow moving ominous transposition upwards
(
Ndef(\a).fadeTime = 5;
Ndef(\a, {
	var snd, snd2;
	var win;
	var sample = b;
	// var trig = [0.5, 0.75, 1.0]; //Impulse.ar(1/[2,3,6]);
	var trig = 1/[5,9];
	win = LFTri.ar(trig);
	snd = PlayBuf.ar(
		numChannels: sample.numChannels,
		bufnum: sample,
		rate:
		[1, 0.25, 1, 1] * LFSaw.ar(1/10).range(1/7, 1).round(0.25)
		// Array.rand(2, 0.5, 1.5).round(0.25) * SinOsc.ar(1/3).range(1, 1.04)
		// [1, 1.25, 1.5, 11.midiratio]
		* BufRateScale.kr(sample),
		trigger: Impulse.ar(trig),
		startPos: 0.1 * SinOsc.ar(1/13).range(0.49, 1.1) //LFPulse.ar(1/4).range(0, 0.01)
		* b.numFrames,
		loop: 1.0
	)
	* win
	;
	/*snd = PitchShift.ar(
		in: snd,
		windowSize: 0.4,
		pitchRatio: 1, //[1/2, 1.25, 1],
		pitchDispersion: 0,
		timeDispersion: 0.01,
		mul: 4
	);
	*/
	// snd = (snd * 1)  + (snd2 * LFNoise2.ar(1/5).range(0.003, 1/9));
	snd = Splay.ar(Splay.ar(snd));
	// snd = snd + RHPF.ar(snd, [60, 67, 70, 75].midicps, 0.1);
	// snd = Normalizer.ar(snd, 0.15);
	// snd = Clip.ar(snd, -0.91, LFNoise1.ar(1).range(0.14771, 0.7195));
	// snd = (snd * LFTri.ar(freq: 1/4, width: 0.1) * SinOsc.ar(1/5)) + (HPF.ar(snd, LFPulse.ar(4).range(1000, 5000), 2) * LFPulse.ar(freq: 1/[4, 5], width: [0.1, 0.301]));
	snd = Splay.ar(snd);
	snd = FreeVerb.ar(snd, 0.45, 0.9);
	snd = Limiter.ar(snd) * Ndef.ar(\vol, 1);
}).play;
)

Ndef(\vol, { Line.ar(0, 1, 10)});
