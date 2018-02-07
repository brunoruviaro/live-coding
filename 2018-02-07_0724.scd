MIDIClient.init;
MIDIClient.destinations
m = MIDIOut(0);

t = TempoClock.new(60/60);

Pbindef(\sc).stop;

(
Pbindef(\sc,
	\type, \midi,
	\scale, Scale.harmonicMinor,
	\degree, Pseq([11, 0, 1, 2, 3, 4, 5, 6], inf),
	\dur, 1/8,
	\amp, 0.5, //Pseq([0.2, Pn(0.1, 7)], inf),
	\midiout, m
).play(t, quant: 4)
)

(
Pbindef(\sc3,
	\type, \midi,
	\midiout, m,
	\scale, Scale.harmonicMinor,
	\degree, Pseq([10, 0, 1, 2, 3, 4, 5, 6], inf),
	\dur, 1/6,
	\mtranspose, -7,
	\amp, 0.5, //Pseq([0.2, Pn(0.1, 7)], inf),
	\legato, 0.8,
	// \midiout, m
).play(t, quant: 4)
)
(
var transp = -0;
Pbindef(\sc, \ctranspose, transp);
Pbindef(\sc1, \ctranspose, transp);
Pbindef(\sc1b, \ctranspose, transp);
Pbindef(\sc2, \ctranspose, transp);
Pbindef(\sc3, \ctranspose, transp);
Pbindef(\sc4, \ctranspose, transp);
Pbindef(\sc5, \ctranspose, transp);
)
(
Pbindef(\sc5,
	\type, \midi,
	\scale, Scale.harmonicMinor,
	\degree, Pseq([9, 7, 0, 1, 2, 3, 4, 5, 6], inf),
	\dur, 1/5,
	\amp, Pseq([0.5, Pn(0.4, 7)], inf),
	\midiout, m
).play(t, quant: 4)
)

(
Pbindef(\sc1,
	\type, \midi,
	\midiout, m,
	\scale, Scale.harmonicMinor,
	\degree, Pseq([8, 0, 1, 2, 3, 4, 5, 6], inf),
	\dur, 2,
	\mtranspose, [-14, -7],
	\amp, Pseq([0.5, Pwhite(0.4, 0.6, 7)], inf),
	\legato, 1,
).play(t, quant: 4)
)

(
Pbindef(\sc1b,
	\type, \midi,
	\midiout, m,
	\scale, Scale.harmonicMinor,
	\degree, Pseq([7, 0, 1, 2, 3, 4, 5, 6], inf),
	\dur, 1,
	\mtranspose, -3,
	\amp, Pseq([0.5, Pwhite(0.4, 0.6, 7)], inf),
	\legato, 1,
).play(t, quant: 4)
)

Pbindef([\sc1, \sc2, \sc3, \sc4], \amp, 0.0)

w = Pbindef.all.keys
[\sc1, \sc2, \sc3, \sc4].do{ arg i; Pbindef(i, \amp, 0.0); }


Pbindef.clear
w.do{ arg i; Pbindef(i, \ctranspose, [0].choose); }

w.do{ arg i; Pbindef(i, \amp, [0].choose); }
