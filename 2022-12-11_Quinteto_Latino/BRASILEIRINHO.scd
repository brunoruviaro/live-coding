Ndef.clear(10)

(
b = Buffer.read(s, "".resolveRelative ++ "QL_Brasileirinho_111622.wav");
e = Env.perc(0.01, 1); //Env([0, 1, 0], [0.5, 0.5], [8, -8]);
z = Buffer.sendCollection(s, e.discretize, 1);
)

// b.play

Ndef.clear(12);


// nice alternate intro, sparse take on the intro
(
Ndef(\a).fadeTime = 5;
Ndef(\a, {
	var snd;
	var win;
	var sample = b;
	var trig = Impulse.ar(1/2 * [1.1, 2] * LFTri.ar(1/[1,3]).range(0.13, 1));

	snd = GrainBuf.ar(
		numChannels: 2,
		trigger: trig,
		dur: [7, 2, 4.3] / 10,
		sndbuf: sample,
		rate: [1, 1.5], //* Env.triangle(3).ar(gate: Impulse.ar(1/3), levelBias: 0.5).poll,
		pos:
		// 0.48
		// [0.27, 0.20, 0.15]
		LFSaw.ar(1/4).range(0.75, 0.85) * LFPulse.ar(1).range(-1, 1)// scan the intro over x seconds
		,
		interp: 4,
		pan: LFNoise0.ar(2).range(-0.5, 0.5),
		mul: 1
	);
	snd = Splay.ar(snd.flat);
	snd = HPF.ar(snd, LFNoise2.ar(3).range(100, 2000));
	snd = Normalizer.ar(snd, 0.4, 0.1);
	snd = FreeVerb.ar(snd, 0.4, 0.78);
	snd = Limiter.ar(snd)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
)



// stretched grainy cloud intro
(
Ndef(\a).fadeTime = 2;
Ndef(\a, {
	var snd;
	var win;
	var sample = b;
	var trig = Impulse.ar(2 * [1, 2, 4, 3.2]);

	snd = GrainBuf.ar(
		numChannels: 2,
		trigger: trig,
		dur: [7, 2, 4.3, 5] / 3,
		sndbuf: sample,
		rate: 1 , //* Env.triangle(3).ar(gate: Impulse.ar(1/3), levelBias: 0.5).poll,
		pos:
		// 0.48
		// [0.27, 0.20, 0.15]
		LFSaw.ar(1/10).range(0.06, 0.169) // scan the intro over x seconds
		,
		interp: 4,
		pan: LFNoise0.ar(2).range(-0.5, 0.5),
		mul: 1
	);
	snd = Splay.ar(snd.flat);
	snd = Normalizer.ar(snd, 0.64, 0.3);
	snd = FreeVerb.ar(snd, 0.4, 0.78);
	snd = Limiter.ar(snd)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
)


// post intro, recognizable loop
(
Ndef(\a).fadeTime = 2;
Ndef(\a, {
	var snd;
	var win;
	var sample = b;
	var trig = Impulse.ar(1/4);

	snd = GrainBuf.ar(
		numChannels: 2,
		trigger: trig,
		dur: [8, 8.1],
		sndbuf: sample,
		rate: [1, 1.001], // * Env.triangle(5).ar(gate: Impulse.ar(1), levelBias: 0.5).poll,
		pos:
		0.45
		// [0.47, 0.50, 0.55]
		,
		interp: 4,
		pan: LFNoise0.ar(2).range(-0.5, 0.5),
		mul: 1
	);
	snd = Splay.ar(snd.flat);
	snd = Normalizer.ar(snd, 0.64, 0.01);
	snd = FreeVerb.ar(snd, 0.4, 0.5);
	snd = Limiter.ar(snd)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
)




// Minor triad loop with surprises
(
Ndef(\a).fadeTime = 5;
Ndef(\a, {
	var snd;
	var win;
	var sample = b;
	var trig = Impulse.ar(10);

	snd = GrainBuf.ar(
		numChannels: 2,
		trigger: trig,// * SinOsc.ar(1/3).range(1, 2),
		dur: Array.rand(4, 0.5, 1.05),
		sndbuf: sample,
		rate: 1 * Env.triangle(0.4).kr(gate: Dust.kr(0.4), levelBias: 1.0),// * LFPulse.ar(1/5, 0, 0.9).range([0.5, 0.25], 1),
		pos: Demand.ar(
			trig: trig,
			reset: 0,
			// demandUGens: Dseq([0.22, 0.4, 0.67, 0.68], inf)
			demandUGens: Dseq(Array.series(4, 0.01, 0.1), inf).min(0.99)
		)
		,
		interp: 4,
		pan: LFNoise0.ar(4),
		mul: 0.5
	);

	snd = Splay.ar(snd.flat);
	snd = Normalizer.ar(snd, 0.5, 0.01);
	snd = FreeVerb.ar(snd, 0.4, 0.8);
	snd = Limiter.ar(snd)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
)



// machine music 1
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
		rate: [0.75, 1, 1.5] * LFPulse.ar(1/5, 0, 0.9).range([0.5, 0.25], 1),
		pos: Demand.ar(
			trig: trig,
			reset: 0,
			// demandUGens: Dseq([0.22, 0.4, 0.67, 0.68], inf)
			demandUGens: Dseq([0.2, 0.4, 0.7, 0.8, 0.21], inf)
			// demandUGens: Dshuf(Array.series(14, 0.2, 0.01), inf)
		)
		,
		interp: 4,
		pan: LFNoise0.ar(4),
		mul: 1.5
	);

	// snd = Splay.ar(snd.flat);
	snd = FreeVerb.ar(snd, 0.6, 0.8);
	snd = Limiter.ar(snd)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
Ndef(\a).quant_(1)
)

// machine music 2 rallentando
(
Ndef(\a).fadeTime = 2;
Ndef(\a, {
	var snd;
	var win;
	var sample = b;
	var trig = Impulse.ar(XLine.kr(20, 3, 20));

	snd = GrainBuf.ar(
		numChannels: 2,
		trigger: trig,
		dur: Array.rand(4, 0.09, 0.39),
		sndbuf: sample,
		rate: [0.75, 1, 1.5] * LFPulse.ar(1/5, 0, 0.9).range([0.5, 0.25], 1),
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
		mul: 1
	);

	snd = Splay.ar(snd);
	snd = Normalizer.ar(snd, 0.65, 0.3);
	snd = FreeVerb.ar(snd, 0.4, 0.5);
	snd = Limiter.ar(snd)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
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

	snd = snd + RHPF.ar(snd, 135 * [0, 2, 9].midiratio * 8, 0.13);
	snd = Normalizer.ar(snd, LFNoise2.ar(1).range(0.21, 0.5), 0.1);
	snd = FreeVerb.ar(snd, 0.54, 0.65);
	snd = Limiter.ar(snd)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
)

// sparse, low, resonant, occasional long tone 1 (sustained)
(
Ndef(\a).fadeTime = 5;
Ndef(\a, {
	var snd;
	var win;
	var sample = b;

	snd = GrainBuf.ar(
		numChannels: 2,
		trigger: Impulse.ar(5/[3,5]) * SinOsc.ar(1/3).range(1, 3),
		dur: Array.rand(4, 0.7, 0.51) * LFPulse.ar(1/4, 0, 0.19).range(1, 4),
		sndbuf: sample,
		rate: [0.999, 1, 1.01] * LFPulse.ar(1/5, 0, 0.9).range([0.5, 0.25], 1) * XLine.ar(0.23, 0.2, 14),
		pos: [0.22, [0.21, 0.24].choose]
		,
		interp: 4,
		pan: LFNoise0.ar(4),
		mul: 1.5
	);

	snd = snd + RHPF.ar(snd, 135 * [0, 2, 9].midiratio * 6, 0.5);
	snd = FreeVerb.ar(snd, 0.54, 0.85);
	snd = Limiter.ar(snd, 0.7)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
)


// gliss up, rhythmic
(
Ndef(\a).fadeTime = 6;
Ndef(\a, {
	var snd;
	var win;
	var sample = b;

	snd = GrainBuf.ar(
		numChannels: 2,
		trigger: Impulse.ar([3,5] * SinOsc.ar(1/2).range(0.5, 14)),
		dur: Array.rand(4, 0.07, 0.1) * LFPulse.ar(1/4, 0, 0.29).range(1, 4),
		sndbuf: sample,
		rate: [0.999, 1, 1.01] * LFPulse.ar(1/5, 0, 0.9).range([0.5, 0.25], 1) * XLine.ar(0.15, 0.39, 14),
		pos: [0.22, [0.21, 0.24, 0.4, 0.12, 0.99].choose]
		,
		interp: 4,
		pan: LFNoise0.ar(4),
		mul: SinOsc.ar(1/[3,4]).range(0.6, 0.9) * [1, 1/1]
	);


	snd = snd + RHPF.ar(snd, 135 * [0, 2, 9].midiratio * 5, 0.15);
	snd = Splay.ar(snd.flat);
	snd = Normalizer.ar(snd, 0.5, 0.2);
	snd = FreeVerb.ar(snd, 0.4, 0.85);
	snd = Limiter.ar(snd)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
)


// sparse, low, resonant, occasional long tone STACCATO
(
Ndef(\a).fadeTime = 5;
Ndef(\a, {
	var snd;
	var win;
	var sample = b;

	snd = GrainBuf.ar(
		numChannels: 2,
		trigger: Impulse.ar(1/[3,5]) * SinOsc.ar(1/3).range(1, 3),
		dur: Array.rand(4, 0.07, 0.1) * LFPulse.ar(1/4, 0, 0.19).range(1, 4),
		sndbuf: sample,
		rate: [0.999, 1, 1.01] * LFPulse.ar(1/5, 0, 0.9).range([0.5, 0.25], 1) * XLine.ar(0.3, 0.2, 14),
		pos: [0.22, [0.21, 0.24].choose]
		,
		interp: 4,
		pan: LFNoise0.ar(4),
		mul: 1.5
	);

	snd = snd + RHPF.ar(snd, 135 * [0, 2, 9].midiratio * 6, 0.05);
	snd = Normalizer.ar(snd, 0.5, 0.1);
	snd = FreeVerb.ar(snd, 0.54, 0.85);
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
	snd = Splay.ar(snd.flat);
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
	snd = RLPF.ar(snd, [440, 880, 1220] *LFNoise2.ar(1/3).range(3, 5), 0.124);
	snd = Splay.ar(snd.flat);
	snd = Normalizer.ar(snd, 0.4, 0.1);
	snd = FreeVerb.ar(snd, 0.4, 0.5, 0.3, 1);
	snd = Limiter.ar(snd)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
)







// distorted, fast moving ominous transposition upwards
Ndef(\vol, { Line.ar(0, 1, 10)});

(
Ndef(\a).fadeTime = 5;
Ndef(\a, {
	var snd, snd2;
	var win;
	var sample = b;
	// var trig = [0.5, 0.75, 1.0]; //Impulse.ar(1/[2,3,6]);
	var trig = [5,9] * LFNoise0.ar(1/2).range(1/2, 2);
	win = LFTri.ar(trig);
	snd = PlayBuf.ar(
		numChannels: sample.numChannels,
		bufnum: sample,
		rate:
		[1, 0.25, 1, 1] * LFSaw.ar(1/10).range(1/4, 1).round(0.125)
		// Array.rand(2, 0.5, 1.5).round(0.25) * SinOsc.ar(1/3).range(1, 1.04)
		// [1, 1.25, 1.5, 11.midiratio]
		* BufRateScale.kr(sample),
		trigger: Impulse.ar(trig),
		startPos: 0.1 * SinOsc.ar(1/13).range(0.049, 1.1) //LFPulse.ar(1/4).range(0, 0.01)
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
	// snd = snd + RHPF.ar(snd, [60, 67, 70, 75].midicps, 0.1);
	snd = Normalizer.ar(snd, 0.75);
	snd = Clip.ar(snd, -0.91, LFNoise1.ar(1).range(0.14771, 0.7195));
	// snd = (snd * LFTri.ar(freq: 1/4, width: 0.1) * SinOsc.ar(1/5)) + (HPF.ar(snd, LFPulse.ar(4).range(1000, 5000), 2) * LFPulse.ar(freq: 1/[4, 5], width: [0.1, 0.301]));
	snd = Splay.ar(snd.flat);
	snd = FreeVerb.ar(snd, 0.5, 0.19);
	snd = Limiter.ar(snd) * Ndef.ar(\vol, 1);
}).play;
)

Ndef(\vol, { Line.ar(0, 1, 10)});
