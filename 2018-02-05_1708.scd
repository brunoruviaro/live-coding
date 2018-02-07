b = Buffer.read(s, "/home/ruviaro/Desktop/2018-02-09/lovemedo.wav");


Ndef(\love).play(fadeTime: 13);

Ndef(\love).fadeTime = 4;
(
Ndef(\love, {
	var snd, snd2, env;
	env = LFTri.ar([3, 4]*MouseY.kr(1/2, 2)).range(0.3, 1);
	snd = PlayBuf.ar(
		numChannels: 2,
		bufnum: b,
		rate: [0.25, -0.25, 0.5, -0.5, -2] * LFSaw.ar([1/2, 5, 1/3]).range(1, 1.1),
		loop: 1).flat;
	snd = LPF.ar(snd, LFNoise2.ar(1/[4, 7]).range(1000, 5000));
	snd2 = HPF.ar(snd, SinOsc.ar([3, 4]).range(500, 12000));
	snd = (snd * 0.953) + (snd2 * 0.951);
	snd = Splay.ar(snd.flat) * env;
}
)
)

Ndef(\rev).fadeTime = 4;
(
Ndef(\rev, { 
	var snd =  Ndef.ar(\love);
	snd = PitchShift.ar(snd, 0.2, [1, 1.5, 1]);
	snd = snd + CombC.ar(snd, 1, [0.035, 0.0453, 0.1], 1);
	snd = Splay.ar(snd);
	// snd = FreeVerb.ar(snd, 0.2, 0.5, 0.6, 3);
	// snd = Limiter.ar(snd);
});
)
Ndef(\out, { ReplaceOut.ar(0, Ndef.ar(\rev)) }).play;

Ndef.clear(10)

