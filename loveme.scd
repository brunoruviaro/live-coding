b = Buffer.read(s, "/home/ruviaro/Desktop/2018-02-09/lovemedo.wav");

Ndef(\love).fadeTime = 4;
(
Ndef(\love, {
	var snd, snd2;
	snd = PlayBuf.ar(
		numChannels: 2,
		bufnum: b,
		rate: [1, 1] * [1, 1.001, 1.001] * MouseX.kr(1, 1.01).round(0.1),
		loop: 1
	);
	snd = LPF.ar(snd, LFNoise1.ar([1, 2, 4]).range(500, 2000));
	snd2 = HPF.ar(snd, SinOsc.ar([2, [3,5].choose, 4]*MouseX.kr(1, 3)).range(8000, 17000), 10);
	snd = SelectX.ar(SinOsc.ar(MouseY.kr(1, 3)).range(0.95, 1), [snd, snd2]);
	snd = snd * [LFTri, SinOsc].choose.ar([2, 5]).range(0.5, 1);
	snd = snd.distort;
	snd = snd * LFPulse.ar([1, 2, 3.1, 0.4], width: [0.1, 0.4, 0.1, 0.1]);
	snd = snd + CombC.ar(snd, 1, [0.02, 0.032, 0.046]*10, [2, 1.4, 3]);
	snd = Splay.ar(snd.flat);
}).play;
)

Ndef(\love).clear(15)