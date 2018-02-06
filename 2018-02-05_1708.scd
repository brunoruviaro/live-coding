b = Buffer.read(s, "/home/ruviaro/Desktop/lovemedo.wav");


Ndef(\love).play(fadeTime: 13);

Ndef(\love).fadeTime = 4;
(
Ndef(\love, {
	var snd, snd2, env;
	env = LFPulse.ar(1/[2, 4]*MouseX.kr(1, 2)).range(0.1, 1);
	snd = PlayBuf.ar(
		numChannels: 2,
		bufnum: b,
		rate: [0.25, -0.25, 0.5, -0.5] * LFSaw.ar([1/2, 5, 1/3]).range(1, 3.7),
		loop: 1).flat;
	snd = LPF.ar(snd, LFNoise2.ar(1/[4, 7]).range(100, 500));
	snd2 = HPF.ar(snd, LFSaw.ar([3, 4]).range(10000, 19000));
	snd = (snd * 0.3) + (snd2 * 0.1);
	snd = Splay.ar(snd.flat) * env;
}
)
)

Ndef(\rev).fadeTime = 4;
(
Ndef(\rev, { 
	var snd =  Ndef.ar(\love);
	snd = PitchShift.ar(snd, 0.2, [1, 1.5, 1]);
	snd = snd + CombC.ar(snd, 1, [0.04, 0.053], 1);
	snd = Splay.ar(snd);
	snd = FreeVerb.ar(snd, 0.6, 0.5, 0.6, 3);
	snd = Limiter.ar(snd);
});
)
Ndef(\out, { ReplaceOut.ar(0, Ndef.ar(\rev)) * XLine.kr(1, 0.000001, 10) }).play;

Ndef.clear(10

