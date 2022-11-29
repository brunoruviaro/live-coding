{ SinOsc.ar!2 * 0.3 }.play

b = Buffer.read(s, "/home/ruviaro/Music/SuperCollider/Brasileirinho/brasileirinho_48kHz.wav");
r = Buffer.read(s, "/home/ruviaro/Music/Bruno_Music/x_Outros/Restringist.aif");
t = Buffer.read(s, "/home/ruviaro/Music/Bruno_Music/x_Outros/Tempulo_041121_Rehearsal.aif");
c = Buffer.read(s, "/home/ruviaro/Music/Sounds/cc-mono-beginning.aiff");
d = Buffer.read(s, "/home/ruviaro/Music/Sounds/Birds.aif");

i = Buffer.read(s, "/home/ruviaro/Music/SuperCollider/Brasileirinho/lamento_intro.wav");
p = Buffer.read(s, "/home/ruviaro/Music/SuperCollider/Brasileirinho/lamento_drums.wav");

p.play

Ndef.clear

(
Ndef(\granulator).fadeTime = 3;
// play with rnd, overlap + grainSize for taste
Ndef(\granulator, { |rate = 1, freqScale=1, grainSize=0.2, overlaps=4, rnd=0.1|
	var snd, snd2;
	var bufnum;
	var raw;
	bufnum = p;
	snd2 = PlayBuf.ar(
		numChannels: bufnum.numChannels,
		bufnum: bufnum,
		rate: [1, 0.5, 1.25],
		trigger: Impulse.ar([1/6, 1/4]),
		startPos: bufnum.numFrames * [0.994, 0.991]
	) * 1/100;
	snd =
		Warp1.ar(
			numChannels: bufnum.numChannels,
			bufnum: bufnum,
			pointer: LFSaw.kr(
				freq: BufDur.kr(bufnum).reciprocal * rate,
				iphase: 1
		).range(0, 1/4) * LFNoise0.ar(1).range(1, 1),
			freqScale: freqScale,
		windowSize: grainSize,
			envbufnum: -1,
			overlaps: overlaps,
			windowRandRatio: rnd
		);
	snd = snd2 * SinOsc.ar(1/5).range(1, 2) + RHPF.ar(snd, Array.rand(7, 143, 6200) * LFPulse.ar([1,2.3,4]).range(1, 2.3), [0.1, 0.3, 0.5, 0.8] * LFNoise2.ar(1).range(0.5, 1), LFTri.ar(1/5).range(0.00, 0.00009));
	snd = snd.distort.distort;
	snd = Splay.ar(snd);
	snd = FreeVerb.ar(snd, 0.3, 0.4);
	snd = Limiter.ar(snd);
}).play;
)

Ndef(\granulator).set(\rate, 1);
Ndef(\granulator).set(\grainsize, 1);