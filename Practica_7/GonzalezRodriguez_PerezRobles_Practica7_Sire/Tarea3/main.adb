
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is

   task type Buffer is
      entry Insertar(D : in Integer);
      entry Extraer(D : out Integer);
   end Buffer;

   task body Buffer is
      Datos : array (1 .. 5) of Integer := (others => 0);
      Inicio, Fin, Count : Integer := 1;

   begin
      loop
         select
            when Count < 5 =>
               accept Insertar(D : in Integer) do
                  Datos(Fin) := D;
                  Fin := (Fin mod 5) + 1;
                  Count := Count + 1;
                  Put_Line("Insertado " & Integer'Image(D));
               end Insertar;
         or
            when Count > 0 =>
               accept Extraer(D : out Integer) do
                  D := Datos(Inicio);
                  Datos(Inicio) := 0;
                  Inicio := (Inicio mod 5) + 1;
                  Count := Count - 1;
                  Put_Line("Extraído " & Integer'Image(D));
               end Extraer;
         end select;
      end loop;
   end Buffer;

   B : Buffer;

   task type Productor;
   task type Consumidor;

   task body Productor is
   begin
      for I in 1 .. 5 loop
         delay 0.5;
         B.Insertar(I);
      end loop;
   end Productor;

   task body Consumidor is
      V : Integer;
   begin
      for I in 1 .. 5 loop
         delay 1.0;
         B.Extraer(V);
      end loop;
   end Consumidor;

   P : Productor;
   C : Consumidor;

begin
   Put_Line("Inicio del programa - Tarea 3");
   delay 10.0;
end Main;
