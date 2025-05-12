node TrafficLight2
  (BOTON: bool)
returns
  (GREEN: bool;
  YELLOW: bool;
  RED: bool;
  WALK: bool;
  DONTWALK: bool);

var
  V8_Fase: int;
  V9_preFase: int;

let
  GREEN = (V8_Fase = 0);
  YELLOW = (V8_Fase = 1);
  RED = (V8_Fase > 1);
  WALK = ((V8_Fase > 2) and (V8_Fase < 4));
  DONTWALK = (not WALK);
  V8_Fase = (if (BOTON and (false -> (pre DONTWALK))) then 1 else (if ((0 < 
  V9_preFase) and (V9_preFase < 4)) then (V9_preFase + 1) else 0));
  V9_preFase = (0 -> (pre V8_Fase));
tel

