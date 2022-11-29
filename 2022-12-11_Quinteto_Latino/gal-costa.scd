// assum preto gal costa
// https://www.youtube.com/watch?v=IzfyDhdSVX0

o = ServerOptions.new;

// Set the memory size to twice the default

o.memSize = 8192 * 1000;


Ndef.clear

s.free


(
Ndef(\gal).fadeTime = 5;
Ndef(\gal, {
	var snd,src;
	src = Mix.ar(SoundIn.ar([0, 1]));
	snd = (src/7 * LFNoise2.ar(1/10).range(0.10, 0.5)) +
	PitchShift.ar(
		in: src,
		windowSize: 0.2,
		pitchRatio: [1, 0.85].scramble,
		pitchDispersion: 0,
		timeDispersion: 0.5,
		mul: [1, 1] * SinOsc.ar(1/[4,2.2]).range(0.30, 0.996)
	);
	/* snd = CombC.ar(
		in: snd,
		maxdelaytime: 1,
		delaytime: [0.13, 0.185],
		decaytime: [5.9, 13],
		mul: 1
	);
	*/

	snd = Clip.ar(snd*20, -0.24, 0.3);

	snd = BPF.ar(snd, LFNoise2.ar(1/[4,10,5]).range(90, [500,1430]), 0.125);
	snd = Splay.ar(snd);
	snd = Normalizer.ar(snd, 0.5, 1);
	snd = FreeVerb.ar(snd * Line.ar(1, 0.0, 60), 0.6, 0.9);
	snd = Limiter.ar(snd);
}).play(numChannels: 2);
)


(
Ndef(\gal).fadeTime = 5;
Ndef(\gal, {
	var snd,src;
	src = Mix.ar(SoundIn.ar([0, 1]));
	snd = (src/7 * LFNoise2.ar(1/10).range(0.10, 0.5)) +
	PitchShift.ar(
		in: src,
		windowSize: 0.2,
		pitchRatio: [1, 0.85].scramble,
		pitchDispersion: 0,
		timeDispersion: 0.5,
		mul: [1, 1] * SinOsc.ar(1/[4,2.2]).range(0.30, 0.996)
	);
	/* snd = CombC.ar(
		in: snd,
		maxdelaytime: 1,
		delaytime: [0.13, 0.185],
		decaytime: [5.9, 13],
		mul: 1
	);
	*/

	snd = Clip.ar(snd*20, -0.24, 0.3);

	snd = BPF.ar(snd, LFNoise2.ar(1/[4,10,5]).range(90, [500,1430]), 0.125);
	snd = Splay.ar(snd);
	snd = Normalizer.ar(snd, 0.5, 1);
	snd = FreeVerb.ar(snd * Line.ar(1, 0.0, 60), 0.6, 0.9);
	snd = Limiter.ar(snd);
}).play(numChannels: 2);
)

Ndef.clear(0)

(
Ndef(\gal).fadeTime = 2;
Ndef(\gal, {
	var snd,src;
	src = Mix.ar(SoundIn.ar([0, 1]));
	snd = HPF.ar(src, LFSaw.ar(1/5).range(rrand(50, 500), 9700) * [1, 1.1, 0.9]);
	snd = LFPulse.ar(
		freq: Array.rand(8, 0.25, 4.5).round(0.23),
		width: Array.rand(4, 0.1, 0.5),
		// mul: SinOsc.ar(1/[1, 2,3, 4])
	) * snd;
	snd = (src * LFNoise2.ar(1/10).range(0.10, 0.5)) +
	PitchShift.ar(
		in: snd,
		windowSize: 0.2,
		pitchRatio: [1, 1.25, 1.5, 4].scramble,
		pitchDispersion: 0.3,
		timeDispersion: 0.5,
		mul: [1, 1, 1, 1] * SinOsc.ar(1/[4,2.2]).range(0.30, 0.996)
	);
/*	snd = CombC.ar(
		in: snd,
		maxdelaytime: 1,
		delaytime: Array.rand(4, 0.1, 0.9),
		decaytime: Array.rand(4, 0.9, 7),
		mul: 1
	);*/

	// snd =
	snd = Splay.ar(snd);
	snd = FreeVerb.ar(snd, 0.6, 0.8);
	snd = Normalizer.ar(snd, 0.8, 1);
	snd = Limiter.ar(snd);
}).play(numChannels: 2);
)

Ndef(\gal).clear;