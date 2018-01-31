a = Scale.major;
a.tuning = \just;
a.ratios

Ndef(\chord).play;
Ndef(\chord).fadeTime = 4;
(
f = {
	Ndef(\chord, { arg freq=110, amp=0.1;
		var snd, env, freqs, snd2, env2;
		freqs = freq * a.ratios * [1, 1, 1, 1, 2, 4].scramble;
		env2 = LFTri.ar(1/[4, 5, 6].scramble) * amp;
		env = SinOsc.ar(1/[ 3, 4, 6].scramble) * amp;
		snd = LFSaw.ar(freqs * [1, 1.01, 1.011, 1.001], mul: env);
		snd = LPF.ar(snd, 1000);
		snd2 = LFPulse.ar(freqs * [1, 1.01, 1.011], mul: env2*0.4);
		snd = SelectX.ar(SinOsc.ar(LFNoise0.kr(3).range(1/5, 1/3)).range(0.1, 0.9), [snd, snd2]);
		snd = snd.distort.distort;
		snd2 = LPF.ar(snd2, 2000);
		snd = Splay.ar(snd);
		snd = RLPF.ar(snd, SinOsc.ar(1/19).range(1500, 5000), 0.1);
		snd = snd + FreeVerb.ar(snd, 0.4, 0.5);
		// snd =
	})
};
)


r = {  300.do({ arg i; f.value; i.postln; rrand(1, 5).wait }) }.fork;

Ndef(\mel).play(fadeTime: 5);

(
~mel = {
	Ndef(\mel, { arg freq=1000, amp=0.05;
		var snd ;
		snd = LFPulse.ar(
			freq: freq + [0, 0, 0, 100, 100, 200, -110, -330, 540, 1000, 1000, 1010].choose * [1, 1.01, 0.999, 1.011] * LFSaw.kr(LFNoise0.ar(1/3).range(1, 4)).range(1, 1.2),
			mul: amp * LFPulse.ar(1/[3, 5, 7]).range(0.2, 1)
		);
		snd = snd.distort;
		snd = snd * LFPulse.kr(MouseY.kr(1/5, 1/6), width: rrand(0.1, 0.7));
		snd = Splay.ar(snd)
		// snd = snd * Line.kr(1, 0, 30);
	})
}
)
~mel.value;
(
~r2.stop;
~r2 = { 100.do({ ~mel.value; rrand(0.2, 1).wait }) }.fork;
)


Ndef(\mel).clear(10)
Ndef.clear(40);

Ndef(\rev).fadeTime = 4;
(
Ndef(\rev, { var in, snd;
	in=In.ar(0, 2);
	snd = FreeVerb.ar(in, 0.3, 0.6);
	snd = CombN.ar(snd, 1, rrand(0.2, 0.5), 4, 0.5) + snd;
	snd = Splay.ar(snd);
	snd=ReplaceOut.ar(0, snd);

})
)