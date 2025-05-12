
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
   type Buffer_Array is array (1 .. 5) of Integer;

   protected Buffer is
      procedure Insertar(D : in Integer);
      procedure Extraer(D : out Integer);
   private
      Datos : Buffer_Array := (others => 0);
      Inicio, Fin, Count : Integer := 1;
   end Buffer;

   protected body Buffer is
      procedure Insertar(D : in Integer) is
      begin
         if Count < 5 then
            Datos(Fin) := D;
            Fin := (Fin mod 5) + 1;
            Count := Count + 1;
            Put_Line("Insertado " & Integer'Image(D));
         else
            Put_Line("Buffer lleno, no se puede insertar.");
         end if;
      end Insertar;

      procedure Extraer(D : out Integer) is
      begin
         if Count > 0 then
            D := Datos(Inicio);
            Datos(Inicio) := 0;
            Inicio := (Inicio mod 5) + 1;
            Count := Count - 1;
            Put_Line("Extraído " & Integer'Image(D));
         else
            Put_Line("Buffer vacío, no se puede extraer.");
         end if;
      end Extraer;
   end Buffer;

   task type Productor;
   task type Consumidor;

   task body Productor is
   begin
      for I in 1 .. 5 loop
         delay 0.5;
         Buffer.Insertar(I);
      end loop;
   end Productor;

   task body Consumidor is
      V : Integer;
   begin
      for I in 1 .. 5 loop
         delay 1.0;
         Buffer.Extraer(V);
      end loop;
   end Consumidor;

   P : Productor;
   C : Consumidor;

begin
   Put_Line("Inicio del programa - Tarea 4");
   delay 10.0;
end Main;
