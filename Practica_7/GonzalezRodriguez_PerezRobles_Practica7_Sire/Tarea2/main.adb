
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is

   protected Buffer is
      procedure Insertar(D : in Integer);
      procedure Extraer(D : out Integer);
   private
      Dato : Integer := 0;
      Ocupado : Boolean := False;
   end Buffer;

   protected body Buffer is
      procedure Insertar(D : in Integer) is
      begin
         if not Ocupado then
            Dato := D;
            Ocupado := True;
            Put_Line("Insertado " & Integer'Image(D));
         end if;
      end Insertar;

      procedure Extraer(D : out Integer) is
      begin
         if Ocupado then
            D := Dato;
            Ocupado := False;
            Put_Line("Extraído " & Integer'Image(D));
         end if;
      end Extraer;
   end Buffer;

   task type Productor;
   task type Consumidor;

   task body Productor is
   begin
      for I in 1 .. 5 loop
         delay 1.0;
         Buffer.Insertar(I);
      end loop;
   end Productor;

   task body Consumidor is
      V : Integer;
   begin
      for I in 1 .. 5 loop
         delay 1.5;
         Buffer.Extraer(V);
      end loop;
   end Consumidor;

   P : Productor;
   C : Consumidor;

begin
   Put_Line("Inicio del programa - Tarea 2");
   delay 6.0;
end Main;
