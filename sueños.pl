%SUEÑOS

%PUNTO1
creeEn(gabriel,campanita).
creeEn(gabriel,magoDeOz).
creeEn(gabriel,cavenaghi).
creeEn(juan,conejoPascua).
creeEn(macarena,reyezMagos).
creeEn(macarena,magoCapria).
creeEn(macarena,campanita).

%suenio(Persona,Suenio,LoQueImplica)
%vender(QueVende,Cantidad)
%vender(Cantidad)
%jugarEquipo(Equipo)
%apostar(ListaNumeros)
suenio(juan,cantante,vender(discos,100000)).
suenio(macarena,cantante(erucaSativa),vender(discos,10000)).
suenio(gabriel,futbolista,jugarEquipo(arsenal)).
suenio(gabriel,ganarLoteria,apostar([5,9])).

%PUNTO2
esAmbicioso(Persona):-		
	dificultades(Persona,ListaDificultades),
	sumlist(ListaDificultades,Total),
	Total>20.

dificultades(Persona,ListaDificultades):-
	suenio(Persona,_,_),
	findall(Dificultad,tieneSuenio(Persona,Dificultad),ListaDificultades).

tieneSuenio(Persona,Dificultad):-
	suenio(Persona,Suenio,Implicancia),
	dificultad(Suenio,Implicancia,Dificultad).

dificultad(cantante,vender(discos,Cantidad),6):-
	Cantidad>500000.
dificultad(cantante(_),vender(discos,Cantidad),4):-
	Cantidad<500000.
dificultad(ganarLoteria,apostar(Numeros),Dificultad):-
	length(Numeros,CantidadNumerosApostados),
	Dificultad is CantidadNumerosApostados*10.
dificultad(futbolista,jugarEquipo(Equipo),3):-
	equipoChico(Equipo).
dificultad(futbolista,jugarEquipo(Equipo),16):-
	not(equipoChico(Equipo)).

equipoChico(arsenal).
equipoChico(aldosivi).

%PUNTO3
tieneQuimica(campanita,Persona):-
	creeEn(Persona,campanita),
	tieneSuenio(Persona,Dificultad),
	Dificultad<5.
tieneQuimica(Personaje,Persona):-
	creeEn(Persona,Personaje),
	todosSueniosPuros(Persona),
	not(esAmbicioso(Persona)),
	Personaje\=campanita.

todosSueniosPuros(Persona):-
	suenio(Persona,_,_),
	forall(suenio(Persona,Suenio,Implicancia),esPuro(Suenio,Implicancia)).

esPuro(futbolista,_).
esPuro(cantante,vender(discos,Cantidad)):-
	Cantidad<200000.
esPuro(cantante(_),vender(discos,Cantidad)):-
	Cantidad<200000.

%PUNTO4
amigo(campanita,reyesMagos).
amigo(campanita,conejoPascua).
amigo(conejoPascua,cavenaghi).

puedeAlegrar(Personaje,Persona):-
	suenio(Persona,_,_).
puedeAlegrar(Personaje,Persona):-
	tieneQuimica(Personaje,Persona),
	condicion(Personaje).

condicion(Personaje):-
	not(enfermo(Personaje)).
condicion(Personaje):-
	amigo(Personaje,PersonajeBackup),
	not(enfermo(PersonajeBackup)).
condicion(Personaje):-
	amigo(Personaje,Tercero),
	condicion(Tercero).

enfermo(campanita).
enfermo(reyesMagos).
enfermo(magoCapria).




