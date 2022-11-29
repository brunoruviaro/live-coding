


e = Env.new(levels: [1, 0.5, 2, 2], times: [1, 2, 2], curve: \sine);

e.plot

Ndef(\local).clear(10)

(
Ndef(\local).fadeTime = 4;
Ndef(\local, {
	var source, snd, freqs;
	var bass;

	var freqenv;

	bass = LPF.ar(
		in: LFSaw.ar(55) * Array.rand(10, 0.9, 1.01),
		freq: 500,
		mul: SinOsc.ar(LFNoise1.ar(1/2).range(0.1, 0.4)).range(0, 0.5)
	);
	freqenv = EnvGen.ar(e, Impulse.ar(1/4), timeScale: 1);
	freqs = [115, 220, 330, 650]/4 * LFSaw.ar(12).range(1, [2,6.0]).round(0.5);
	source = LFTri.ar(freqs) * LFSaw.ar(1/[13, 4, 9]).range(1, 0).pow([1,10]);
	source = source + (bass * LFNoise1.ar(100)) + SinOsc.ar(freqs * LFPulse.ar(rrand(5,17)).range(13, 32)) * LFSaw.ar(1/[1, 2, 3]).range(1, 0).pow(12);
	snd = LocalIn.ar(2) + Splay.ar(source);


	snd = DelayN.ar(snd, 1, Array.rand(4, 0.12, 0.99));
	snd = snd.distort * 4;
	snd = Clip.ar(snd, -0.15, 0.15);
	snd = snd + RLPF.ar(
		in: snd +
		PitchShift.ar(bass.distort.distort, 0.2, [1, 0.75, 1.2], 0.2),
		freq: LFNoise2.ar(Array.rand(4, 1/2, 3.0)).range(100, 2500),
		rq: Array.rand(4, 0.05, 0.23),
		mul: Array.rand(4, 0.6, 0.91)
	);
	snd = snd + RHPF.ar(
		in: snd + WhiteNoise.ar(LFPulse.ar(rrand(1,MouseY.kr(10, 140)), 0, 0.1, 0.3)),
		freq: LFNoise2.ar(Array.rand(4, 1, 2.0)).range(30, 500),
		rq: Array.rand(4, 0.05, 0.095),
		mul: Array.rand(4, 0.001, 0.1)
	);

	LocalOut.ar(Splay.ar(snd) * LFPulse.ar(1, 0, 0.9).range(0, 0.2497));

	snd.size.postln;
	// snd = Mix.ar(snd);
	snd = Pan2.ar(snd, LFNoise2.ar([1,2,3,1]));
	snd = FreeVerb.ar(snd, 0.5, 0.9);
	snd = Limiter.ar(snd) * 0.1;
}).play;
)