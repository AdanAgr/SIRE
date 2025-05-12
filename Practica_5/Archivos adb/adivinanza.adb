
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;

procedure Adivinanza is

   -- Genera el Numero Aleatorio 
   subtype Rango is Integer range 1 .. 100;
   package Random_Int is new Ada.Numerics.Discrete_Random(Rango);
   use Random_Int;
   Gen : Generator;
   Secreto : Rango;

   -- Variables 
   Intento : Integer;
   Adivino : Boolean := False;
   Cuenta_Intentos : Integer := 0;

begin
   
   Reset(Gen);
   Secreto := Random(Gen);

   Put_Line("¡Bienvenido al juego de adivinanza!");
   Put_Line("Adivina el número entre 1 y 100.");

   loop
      Put("Tu intento: ");
      begin
         Get(Intento);
         Cuenta_Intentos := Cuenta_Intentos + 1;

         if Intento = Secreto then
            Adivino := True;
            exit;
         elsif Intento < Secreto then
            Put_Line("El número es mayor.");
         else
            Put_Line("El número es menor.");
         end if;
      exception
         when others =>
            Put_Line("Entrada inválida. Por favor, ingresa un número.");
            Skip_Line;
      end;
   end loop;

   Put_Line("¡Felicidades! Adivinaste el número en " & Integer'Image(Cuenta_Intentos) & " intento(s).");

end Adivinanza;
