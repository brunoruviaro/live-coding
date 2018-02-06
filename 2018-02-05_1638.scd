p = Pbind(\degree, Pseq([0, 1, 2, 3, 4], inf), \dur, 0.1).play

p.stop;

Ndef(\mess).fadeTime = 1;
(
Ndef(\mess, {var amp=1;
	var snd, snd2;
	snd = In.ar(0, 2);
	snd2 = PitchShift.ar(snd, 0.2, LFNoise2.kr([1, 2, 3]).range(6, 7) * [1, 1.2, 1.5], 0.0, 0.5, 2);
	snd = CombN.ar(snd, 1, LFNoise0.kr(1).range(0.05, 0.2).round(0.05), 4, LFPulse.ar(MouseX.kr(2, 5).round(0.5), width: 0.41
	)) * 0.4;
	snd = snd + CombN.ar(snd2, 1, 0.0544, 3, LFPulse.ar([2, 3, 4]+SinOsc.kr(1/4).range(1, 2), width: 0.6));
	snd = Splay.ar(snd);
	snd = (snd*LFTri.ar(1/5).range(0.0, 0.1)) + BPF.ar(snd, LFNoise1.kr(1/6).range(11500, 18000), 0.01, 7);
	snd = FreeVerb.ar(snd, 0.7, 0.5, 0.2) * 0.5;
}).play;
)

Ndef(\mess).clear(10)

Ndef(\out, { ReplaceOut.ar(0, Ndef.ar(\mess, 2)) });




