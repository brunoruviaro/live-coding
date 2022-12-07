i = Buffer.read(s, "".resolveRelative ++ "lamento_intro.wav");
d = Buffer.read(s, "".resolveRelative ++ "lamento_drums.wav");
(
e = Env.perc(0.01, 1); //Env([0, 1, 0], [0.5, 0.5], [8, -8]);
z = Buffer.sendCollection(s, e.discretize, 1);
)


// start with raw sample with a bit of echo

Ndef.clear(10)
(
Ndef(\lamento, {
	var snd;
	snd = PlayBuf.ar(i.numChannels, i, BufRateScale.kr(i));
	snd = Pan2.ar(snd);
	snd = FreeVerb.ar(snd, 0.4, Line.ar(0.001, 0.8, i.duration));
	snd = snd + CombC.ar(
		in: snd * Env.pairs([[0, 0], [6.5, 0], [7.6, 0.35], [14, 0], [34, 0], [35.5, 0.5]], \lin).kr,
		maxdelaytime: 1.0,
		delaytime: rrand(0.5, 0.93),
		decaytime: [7,8]
	);
	snd = Limiter.ar(snd) * 3;
}).play;
)


// near the end start this
Ndef(\vol, { XLine.ar(0.01, 3, 10)});

// Ndef(\a).clear(10);

// droney, glitchy intro
// move it up over time (transpose)
// then add drums
(
Ndef(\a).fadeTime = 2;
Ndef(\a, {
	var snd, snd2;
	var win;
	var sample = i;
	// var trig = [0.5, 0.75, 1.0]; //Impulse.ar(1/[2,3,6]);
	var trig = [1.0, 1.01, 1.02] * 1/8;
	win = LFTri.ar(trig) * 3;
	snd = PlayBuf.ar(
		numChannels: sample.numChannels,
		bufnum: sample,
		rate:
		1
		// * Array.rand(4, 0.5, 1.5).round(0.25)
		// * Env.perc(releaseTime: 4).kr(gate: Impulse.kr(1/10), levelBias: 2.5)
		// [1, 1.25, 1.5, 11.midiratio]
		,
		trigger: Impulse.ar(trig),
		startPos: LFPulse.ar(1/4).range(0.89, 0.91)
		// vocal sample is at 0.9
		* sample.numFrames,
		loop: 1.0
	)
	* win
	;
	// snd = snd + BPF.ar(snd, [3400, 1000, 2400], 0.5, 4);
	snd = snd * LFNoise2.ar(1/[1, 2, 3, 4]).range(0.02, 1);
	snd2 = GrainBuf.ar(
		numChannels: 2,
		trigger: Impulse.ar([4, 3, 5]),
		dur: Array.rand(4, 0.2, 1),
		sndbuf: sample,
		rate: [0.5, 1] * LFPulse.ar(3.6).range(0.75, 3.25) * XLine.ar(1, [0.9999, 1/3], 40) * 1.neg,
		pos: LFNoise2.ar(1/rrand(3, 5)).range(0.05, 0.31)
		,
		interp: 4,
		pan: LFNoise0.ar(4),
		mul: 1,
		// envbufnum: z
	);
	snd = snd + PitchShift.ar(
		in: snd * 0.001,
		windowSize: 0.4,
		pitchRatio: [0, 3, 7].midiratio, //1.2, //[1/2, 1.25, 1],
		pitchDispersion: 0,
		timeDispersion: 0.0,
		mul: 2
	);
	snd = snd + CombC.ar(
		in: snd * LFNoise2.ar(1/5).range(0, 1) * LFPulse.ar(1/5, 0, 0.2),
		maxdelaytime: 1.0,
		delaytime: rrand(0.5, 0.93) * [1, 1.2],
		decaytime: [7,8]
	);
	snd = (snd * LFNoise2.ar(1/6).range(0.85, 2))  + (snd2 * LFNoise2.ar(1/5).range(0.001, 0.15));
	snd = Splay.ar(Splay.ar(snd.flat));
	// snd = Normalizer.ar(snd, 0.95);
	// snd = Clip.ar(snd, -0.31, LFNoise1.ar(1).range(0.14771, 0.5195));
	// snd = (snd * LFTri.ar(freq: 1/4, width: 0.1) * SinOsc.ar(1/5)) + (HPF.ar(snd, LFPulse.ar(4).range(1000, 5000), 2) * LFPulse.ar(freq: 1/[4, 5], width: [0.1, 0.301]));
	snd = FreeVerb.ar(snd, 0.5, 0.97, 0.8);
	snd = Limiter.ar(snd) * Ndef.ar(\vol, 1);
}).play;
)


// near the end start this
Ndef(\vol, { LFNoise2.ar(1).range(0.1, 0.9)});

// drums phasing super duper rhythm
(
Ndef(\d).fadeTime = 0;
Ndef(\d, {
	var snd;
	var win;
	var sample = d;
	// var trig = [0.5, 0.75, 1.0]; //Impulse.ar(1/[2,3,6]);
	var trig = 1/10;
	win = Env.perc(0.01, 5/trig).kr(gate: Impulse.kr(trig));
	// win = LFPulse.ar(trig, 0, 0.4);
	snd = PlayBuf.ar(
		numChannels: sample.numChannels,
		bufnum: sample,
		rate: 1
		* 1

		// * [1, 0.75]
		// * [-10, 4, 7].midiratio
		// * [1, 1/2]
		// * [-1, 5, 7].midiratio
		// * [1, 1, 1.15, 1.2] / 1
		,
		trigger: Impulse.ar(trig),
		startPos: 0
		// + LFPulse.ar(1/[4, 4.01, 3.9]).range(0.00, 0.51)
		// + LFSaw.ar(1/20).range(0, 0.05) // offset
		+ 0.4// sweet spot
		// + 0.1
		// * 1.0
		* sample.numFrames,
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
	// snd = snd + RLPF.ar(snd, LFNoise2.ar(5).range(430, 1400).round(100), 0.1, 1/4);

	// snd = snd + RHPF.ar(snd, LFNoise1.ar(5).range(1000, 8500).round(100), 0.12, LFPulse.ar(1/5).range(0, 0.29));
	snd = Splay.ar(Splay.ar(snd));
	// snd = Normalizer.ar(snd, 0.9);
	// snd = Clip.ar(snd, [-0.5, -0.9], LFNoise1.ar(1).range(0.771, 0.995));
	// snd = FreeVerb.ar(snd, 0.4, 0.9);
	snd = Limiter.ar(snd) * 3;
}).play;
)

Ndef(\d).stop(4)


// drony nice to come after drums

(
Ndef(\c).fadeTime = 2;
Ndef(\c, {
	var snd;
	var win;
	var sample = i;
	snd = GrainBuf.ar(
		numChannels: 1,
		trigger: Impulse.ar([12, 13, 15]) * LFTri.ar(1/10).range(1, 0.2),
		dur: [0.8, 0.15, 0.1] * LFPulse.ar(1/2).range(1, 3),
		sndbuf: sample,
		rate: [1, 2.5] * ([0, 3, 7].midiratio)

		, //LFPulse.ar(1/6).range(0.75, 1.25) * XLine.ar(1, [0.9999, 1], 60) * 1.neg,
		pos: SinOsc.ar(1/4).range(0.69, 0.91) * LFPulse.ar(2).range(0.97, 1), //LFNoise2.ar(1/rrand(3, 5)).range(0, 1/2).round(0.15) + SinOsc.ar(1/10).range(0.09, 0.092),
		interp: 4,
		// pan: LFNoise2.ar(4)
	);
	snd = RLPF.ar(snd, LFSaw.ar(1/8).range(100, 3000).round(50), 0.5);
	// snd = LFPulse.ar(SinOsc.ar(1).range(5, 10)).range(0.5, 1.0) * snd;

	snd = Splay.ar(snd.flat);
	snd = FreeVerb.ar(snd, 0.5, 0.86, 0.6);
	snd = Limiter.ar(snd, 1);
}).play;
)

Ndef(\a).clear
Ndef(\c).stop(14)


// shorter, sparser
(
Ndef(\c).fadeTime = 13;
Ndef(\c, {
	var snd;
	var win;
	var sample = i;
	snd = GrainBuf.ar(
		numChannels: 1,
		trigger: Impulse.ar([12, 13, 15]) * LFTri.ar(1/10).range(1, 0.2),
		dur: [0.38, 0.15, 0.1] * LFPulse.ar(1/2).range(1/3, 1),
		sndbuf: sample,
		rate: [1/2, 1.5] * ([0, 4, 7].midiratio)

		, //LFPulse.ar(1/6).range(0.75, 1.25) * XLine.ar(1, [0.9999, 1], 60) * 1.neg,
		pos: SinOsc.ar(1/4).range(0.69, 0.91) * LFPulse.ar(2).range(0.97, 1), //LFNoise2.ar(1/rrand(3, 5)).range(0, 1/2).round(0.15) + SinOsc.ar(1/10).range(0.09, 0.092),
		interp: 4,
		// envbufnum: z
		// pan: LFNoise2.ar(4)
	);
	snd = (snd/10) + RLPF.ar(snd, LFSaw.ar(1/4).range(400, 1000).round(50), 0.5);
	// snd = LFPulse.ar(SinOsc.ar(1).range(5, 10)).range(0.5, 1.0) * snd;

	snd = Splay.ar(snd.flat);
	snd = FreeVerb.ar(snd, 0.5, 0.6);
	snd = Limiter.ar(snd, 1) * 2;
}).play;
)

//loopy  rhythm filter up low

(
Ndef(\c).fadeTime = 14;
Ndef(\c, {
	var snd;
	var win;
	var sample = i;
	snd = GrainBuf.ar(
		numChannels: 1,
		trigger: Impulse.ar([12, 13, 15]),
		dur: [0.38, 0.15, 0.1] * LFPulse.ar(1/2).range(1/3, 1/2),
		sndbuf: sample,
		rate: [1/2, 1.5] * ([0, 7, 12].midiratio)

		, //LFPulse.ar(1/6).range(0.75, 1.25) * XLine.ar(1, [0.9999, 1], 60) * 1.neg,
		pos: SinOsc.ar(1/4).range(0.69, 0.71) * LFPulse.ar(2).range(0.9, 1), //LFNoise2.ar(1/rrand(3, 5)).range(0, 1/2).round(0.15) + SinOsc.ar(1/10).range(0.09, 0.092),
		interp: 4,
		// pan: LFNoise2.ar(4)
	);
	snd = RLPF.ar(snd, LFTri.ar(1/4).range(300, 2500).round(50) * XLine.ar(1, 1.2, 20), 0.5);
	// snd = LFPulse.ar(SinOsc.ar(1).range(5, 10)).range(0.5, 1.0) * snd;

	snd = Splay.ar(snd.flat);
	snd = FreeVerb.ar(snd, 0.5, 0.8);
	snd = Limiter.ar(snd, 1);
}).play;
)


(
Ndef(\bass).fadeTime = 0;
Ndef(\bass, {
	var snd;
	snd = LFTri.ar(
		freq: LFPulse.ar(1/4.1).range(83, 97) * [1, 1.01, 1.012] * LFPulse.ar(1/6, 0, 0.1).range(0.5, 1),
		mul: LFTri.ar(1/12).range(0.3, 0.85)
	);

	snd = snd.distort.distort.distort.distort;
	snd = Splay.ar(snd.flat);
	// snd = FreeVerb.ar(snd, 0.35, 0.6);
	snd = Limiter.ar(snd, 1) * 2;
}).play;
)


(
Ndef(\lamento, {
	var snd;
	snd = PlayBuf.ar(i.numChannels, i, BufRateScale.kr(i));
	snd = Pan2.ar(snd);
	snd = FreeVerb.ar(snd, 0.4, Line.ar(0.001, 0.8, i.duration));
	snd = snd + CombC.ar(
		in: snd * Env.pairs([[0, 0], [6.5, 0], [7.6, 0.35], [14, 0], [34, 0], [35.5, 0.5]], \lin).kr,
		maxdelaytime: 1.0,
		delaytime: rrand(0.5, 0.93),
		decaytime: [7,8]
	);
	snd = Limiter.ar(snd) * 3;
}).play;
)



Ndef.clear(30);