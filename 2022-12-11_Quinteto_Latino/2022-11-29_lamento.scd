

d = Buffer.read(s, "/home/ruviaro/Music/Sounds/Birds.aif");

i = Buffer.read(s, "".resolveRelative ++ "lamento_intro.wav");
d = Buffer.read(s, "".resolveRelative ++ "lamento_drums.wav");

i.play


Ndef(\vol, { Line.ar(0, 0.2, 20)});

Ndef(\a).stop(10);

// droney, glitchy intro
(
Ndef(\a).fadeTime = 2;
Ndef(\a, {
	var snd, snd2;
	var win;
	var sample = i;
	// var trig = [0.5, 0.75, 1.0]; //Impulse.ar(1/[2,3,6]);
	var trig = [1.0, 1.01, 1.02] * 1/4;
	win = LFTri.ar(trig);
	snd = PlayBuf.ar(
		numChannels: sample.numChannels,
		bufnum: sample,
		rate:
		1
		// Array.rand(4, 0.5, 1.001).round(0.25)
		// [1, 1.25, 1.5, 11.midiratio]
		,
		trigger: Impulse.ar(trig),
		startPos: 0.09 //LFPulse.ar(1/4).range(0, 0.01)
		// vocal sample is at 0.9
		* sample.numFrames,
		loop: 1.0
	)
	* win
	;
	snd = snd * LFNoise2.ar(1/[1, 2, 3, 4]).range(0.02, 1);
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
	/*snd = PitchShift.ar(
		in: snd,
		windowSize: 0.4,
		pitchRatio: 1, //[1/2, 1.25, 1],
		pitchDispersion: 0,
		timeDispersion: 0.01,
		mul: 4
	);
	*/
	snd = (snd * LFNoise2.ar(1/6).range(0, 1) * 0.1)  + (snd2 * LFNoise2.ar(1/5).range(0.001, 0.05));
	snd = Splay.ar(Splay.ar(snd));
	snd = Normalizer.ar(snd, 0.75);
	snd = Clip.ar(snd, -0.31, LFNoise1.ar(1).range(0.14771, 0.5195));
	// snd = (snd * LFTri.ar(freq: 1/4, width: 0.1) * SinOsc.ar(1/5)) + (HPF.ar(snd, LFPulse.ar(4).range(1000, 5000), 2) * LFPulse.ar(freq: 1/[4, 5], width: [0.1, 0.301]));
	snd = FreeVerb.ar(snd, 0.65, 0.9);
	snd = Limiter.ar(snd) * Ndef.ar(\vol, 1) * 0.85;
}).play;
)




(
Ndef(\a).fadeTime = 0;
Ndef(\a, {
	var snd;
	var win;
	var sample = d;
	// var trig = [0.5, 0.75, 1.0]; //Impulse.ar(1/[2,3,6]);
	var trig = 1.0;
	win = Env.perc(0.1, 2/trig).kr(gate: Impulse.kr(trig));
	// win = win* LFPulse.ar(trig, 0, 0.4);
	snd = PlayBuf.ar(
		numChannels: sample.numChannels,
		bufnum: sample,
		rate: 1
		* 1

		// * [-10, 4, 7].midiratio
		// * [0, 3, 7].midiratio
		// * [-1, 5, 7].midiratio
		// * [1, 1, 1.15, 1.2] / 1
		,
		trigger: Impulse.ar(trig),
		startPos: 0
		// LFPulse.ar(1/[4, 4.01, 3.9]).range(0.00, 0.51)
		+ LFSaw.ar(1/20).range(0, 0.05) // offset
		// + 0.1
		// * 1.0
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
	// snd = snd + RLPF.ar(snd, LFNoise2.ar(1/15).range(4300, 1400), 0.13, 1.5);

	// snd = snd + RHPF.ar(snd, LFNoise1.ar(5).range(1000, 8500).round(100), 0.12, LFPulse.ar(1/5).range(0, 0.29));
	snd = Splay.ar(Splay.ar(snd));
	// snd = Normalizer.ar(snd, 0.5);
	// snd = Clip.ar(snd, [-0.5, -0.9], LFNoise1.ar(1).range(0.771, 0.995));
	// snd = FreeVerb.ar(snd, 0.4, 0.9);
	snd = Limiter.ar(snd);
}).play;
)

Ndef(\a).stop(14)

(
Ndef(\c).fadeTime = 1;
Ndef(\c, {
	var snd;
	var win;
	var sample = i;
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