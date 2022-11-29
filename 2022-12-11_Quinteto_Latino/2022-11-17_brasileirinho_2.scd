Ndef.clear(10)

b = Buffer.read(s, "/home/ruviaro/Music/SuperCollider/Brasileirinho/QL_Brasileirinho_111622.wav");

b.play

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
		dur: [8,7],
		sndbuf: sample,
		rate: 1, //* Env.triangle(5).ar(gate: Impulse.ar(1), levelBias: 0.5).poll,
		pos:
		0.47
		//[0.70, 0.58]
		,
		interp: 4,
		pan: LFNoise0.ar(2),
		mul: 1
	);
	snd = Splay.ar(snd.flat);
	// snd = Normalizer.ar(snd, 0.4, 0.1);
	snd = FreeVerb.ar(snd, 0.4, 0.58);
	snd = Limiter.ar(snd)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
)


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
		dur: Array.rand(4, 0.9, 1),
		sndbuf: sample,
		rate: 1 * Env.triangle(0.4).kr(gate: Dust.kr(0.4), levelBias: 1.0),// * LFPulse.ar(1/5, 0, 0.9).range([0.5, 0.25], 1),
		pos: Demand.ar(
			trig: trig,
			reset: 0,
			// demandUGens: Dseq([0.22, 0.4, 0.67, 0.68], inf)
			demandUGens: Dseq(Array.series(14, 0.01, 0.1), inf).min(0.99)
		)
		,
		interp: 4,
		pan: LFNoise0.ar(4),
		mul: 0.5
	);

	snd = Splay.ar(snd.flat);
	snd = FreeVerb.ar(snd, 0.4, 0.8);
	snd = Limiter.ar(snd)// * Ndef.ar(\vol, 1) * 0.85;
}).play;
)

SCLOrkSynths.gui
(
Ndef(\dr,
	Pbind(
		\instrument, \kickBlocks,
		\dur, Prand([1/4, Pn(1/8, 2)], inf),
		\amp, Pwhite(0.4, 0.6)
	)
).play;
Ndef(\dr).quant_(1);
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
		trigger: trig,// * SinOsc.ar(1/3).range(1, 2),
		dur: LFSaw.ar(1/4).range(0.05, 0.31), // Array.rand(4, 0.9, 1),
		sndbuf: sample,
		rate: [0.75, 1, 1.5],// * LFPulse.ar(1/5, 0, 0.9).range([0.5, 0.25], 1),
		pos: Demand.ar(
			trig: trig,
			reset: 0,
			// demandUGens: Dseq([0.22, 0.4, 0.67, 0.68], inf)
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

// thin, middle register loop with low note every x seconds
(
Ndef(\a).fadeTime = 5;
Ndef(\a, {
	var snd;
	var win;
	var sample = b;

	snd = GrainBuf.ar(
		numChannels: 2,
		trigger: Impulse.ar([3,5]) * SinOsc.ar(1/3).range(1, 2),
		dur: Array.rand(4, 0.2, 0.3),
		sndbuf: sample,
		rate: [0.999, 1, 1.01] * LFPulse.ar(1/5, 0, 0.9).range([0.5, 0.25], 1),
		pos: [0.22, [0.21, 0.24].choose]
		,
		interp: 4,
		pan: LFNoise0.ar(4),
		mul: 1.5
	);

	snd = FreeVerb.ar(snd, 0.4, 0.5);
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



(
Ndef(\a).fadeTime = 5;
Ndef(\a, {
	var snd, snd2;
	var win;
	var sample = b;
	// var trig = [0.5, 0.75, 1.0]; //Impulse.ar(1/[2,3,6]);
	var trig = [3,4];
	win = SinOsc.ar(trig*[2.3,1,1.1]);
	snd = PlayBuf.ar(
		numChannels: sample.numChannels,
		bufnum: sample,
		rate:
		[1, 1.25, 1.5, 2] * LFNoise0.ar(1).range(1/3, 2).round(0.25)
		// Array.rand(2, 0.5, 1.5).round(0.25) * SinOsc.ar(1/3).range(1, 1.04)
		// [1, 1.25, 1.5, 11.midiratio]
		* BufRateScale.kr(sample),
		trigger: Impulse.ar(trig),
		startPos: 0.1 * SinOsc.ar(3).range(0.49, 1.1) //LFPulse.ar(1/4).range(0, 0.01)
		* b.numFrames,
		loop: 1.0
	)
	* win
	;
	snd = snd * LFNoise2.ar(1/[1, 2, 3, 4]).range(0.02, 1);
	// snd = Gate.ar(snd, SinOsc.ar(1/[2,3]));// * LFPulse.ar(LFTri.ar(1).range(1/4, 14)));
	/*snd.pow(2)
	snd2 = GrainBuf.ar(
		numChannels: 2,
		trigger: Impulse.ar([4, 3, 5]) * 10,
		dur: Array.rand(4, 0.2, 1),
		sndbuf: sample,
		rate: [0.5, 1], //LFPulse.ar(1/6).range(0.75, 1.25) * XLine.ar(1, [0.9999, 1], 60) * 1.neg,
		pos: LFNoise2.ar(1/rrand(3, 5)).range(0.05, 0.31)
		,
		interp: 4,
		pan: LFNoise0.ar(4),
		mul: 5
	);
	*/
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
	snd = snd + RHPF.ar(snd, [60, 67, 70, 75].midicps, 0.1);
	snd = Normalizer.ar(snd, 0.5);
	snd = Clip.ar(snd, -0.91, LFNoise1.ar(1).range(0.14771, 0.7195));
	// snd = (snd * LFTri.ar(freq: 1/4, width: 0.1) * SinOsc.ar(1/5)) + (HPF.ar(snd, LFPulse.ar(4).range(1000, 5000), 2) * LFPulse.ar(freq: 1/[4, 5], width: [0.1, 0.301]));
	snd = Splay.ar(snd);
	snd = FreeVerb.ar(snd, 0.45, 0.9);
	snd = Limiter.ar(snd) * Ndef.ar(\vol, 1) * 0.85;
}).play;
)

Ndef(\vol, { Line.ar(0, 1, 10)});


(
Ndef(\a1).fadeTime = 0;
Ndef(\a1, {
	var snd;
	var win;
	var sample = b;
	// var trig = [0.5, 0.75, 1.0]; //Impulse.ar(1/[2,3,6]);
	var trig = 1.0;
	win = LFTri.ar(trig);
	snd = PlayBuf.ar(
		numChannels: sample.numChannels,
		bufnum: sample,
		rate: 1
		* 1

		// * [-10, 4, 7].midiratio
		// * [0, 3, 7].midiratio
		// [-1, 5, 7].midiratio
		// * [1, 1, 1.15, 1.2] / 1
		,
		trigger: Impulse.ar(trig),
		startPos: 0
		// LFPulse.ar(1/[4, 4.01, 3.9]).range(0.00, 0.51)
		+ LFSaw.ar(1/15).range(0, 0.2) // offset
		// + 0.1
		// * 1.0
		* b.numFrames,
		loop: 1.0
	)
	// * win
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
	// snd = snd + RLPF.ar(snd, LFNoise2.ar(1/15).range(4300, 1400), 0.13, 1.5);

	snd = snd + RHPF.ar(snd, LFNoise0.ar(15).range(1000, 2500).round(200), 0.12, LFPulse.ar(15).range(0, 0.29));
	snd = Splay.ar(Splay.ar(snd));
	snd = Normalizer.ar(snd, 0.75);
	// snd = Clip.ar(snd, [-0.5, -0.9], LFNoise1.ar(1).range(0.771, 0.995));
	// snd = FreeVerb.ar(snd, 0.4, 0.9);
	snd = Limiter.ar(snd) * 0.7;
}).play;
)

Ndef(\a1).stop(14)

(
Ndef(\c).fadeTime = 1;
Ndef(\c, {
	var snd;
	var win;
	var sample = b;
	snd = GrainBuf.ar(
		numChannels: 2,
		trigger: Impulse.ar([12, 13, 15]) * LFTri.ar(1/10).range(1, 0.1),
		dur: [0.8, 0.15, 0.1] * LFPulse.ar(1/2).range(1, 3),
		sndbuf: sample,
		rate: [1, 2.5] * (0.midiratio), //LFPulse.ar(1/6).range(0.75, 1.25) * XLine.ar(1, [0.9999, 1], 60) * 1.neg,
		pos: SinOsc.ar(1/4).range(0.7, 0.9) * LFPulse.ar(2).range(0.95, 1), //LFNoise2.ar(1/rrand(3, 5)).range(0, 1/2).round(0.15) + SinOsc.ar(1/10).range(0.09, 0.092),
		interp: 4,
		pan: LFNoise2.ar(4)
	);
	// snd = LFPulse.ar(SinOsc.ar(1).range(5, 10)).range(0.5, 1.0) * snd;
	// snd = FreeVerb.ar(snd, 0.14, 0.86, 0.3, 2);
	snd = Limiter.ar(snd, 1);
}).stop;
)

Ndef(\c).stop(14)