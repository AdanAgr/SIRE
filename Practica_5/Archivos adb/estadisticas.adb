with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Float_Text_IO;   use Ada.Float_Text_IO;

procedure Estadisticas is

   -- Definir el tamaño máximo del array
   Max_Valores : constant := 100;

   -- Declarar el tipo de array
   type Lista is array(1 .. Max_Valores) of Float;

   -- Variables 
   Valores : Lista;
   N       : Integer;
   Leidos  : Integer := 0;

   -- Función para calcular el mínimo
   function Minimo(Datos : Lista; Tamano : Integer) return Float is
      Min : Float := Datos(1);
   begin
      for I in 2 .. Tamano loop
         if Datos(I) < Min then
            Min := Datos(I);
         end if;
      end loop;
      return Min;
   end Minimo;

   -- Función para calcular el máximo
   function Maximo(Datos : Lista; Tamano : Integer) return Float is
      Max : Float := Datos(1);
   begin
      for I in 2 .. Tamano loop
         if Datos(I) > Max then
            Max := Datos(I);
         end if;
      end loop;
      return Max;
   end Maximo;

   -- Función para calcular la media
   function Media(Datos : Lista; Tamano : Integer) return Float is
      Suma : Float := 0.0;
   begin
      for I in 1 .. Tamano loop
         Suma := Suma + Datos(I);
      end loop;
      return Suma / Float(Tamano);
   end Media;

   -- Función para calcular la varianza
   function Varianza(Datos : Lista; Tamano : Integer) return Float is
      M : Float := Media(Datos, Tamano);
      Suma : Float := 0.0;
   begin
      for I in 1 .. Tamano loop
         Suma := Suma + (Datos(I) - M) ** 2;
      end loop;
      return Suma / Float(Tamano);
   end Varianza;

begin
   Put_Line("Ingrese la cantidad de números (máx 100): ");
   loop
      begin
         Get(N);  -- lectura de entero
         exit when N >= 1 and N <= Max_Valores;
      exception
         when others =>
            Put_Line("Por favor ingrese un número válido.");
            Skip_Line;
      end;
   end loop;

   Put_Line("Ingrese los " & Integer'Image(N) & " números:");

   while Leidos < N loop
      declare
         Valor : Float;
      begin
         Get(Valor);
         Leidos := Leidos + 1;
         Valores(Leidos) := Valor;
      exception
         when others =>
            Put_Line("Entrada inválida. Intente de nuevo:");
            Skip_Line;
      end;
   end loop;

   Put_Line("Estadísticas calculadas:");
   Put_Line("Mínimo   : "); Put(Minimo(Valores, N)); New_Line;
   Put_Line("Máximo   : "); Put(Maximo(Valores, N)); New_Line;
   Put_Line("Media    : "); Put(Media(Valores, N)); New_Line;
   Put_Line("Varianza : "); Put(Varianza(Valores, N)); New_Line;

end Estadisticas;

