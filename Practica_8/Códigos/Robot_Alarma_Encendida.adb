with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Robot is

   type Estado_Tipo is record
      Hay_Obstaculo  : Boolean := False;
      Camino_Libre   : Boolean := False;
      Bateria_Baja   : Boolean := False;
   end record;

   type Accion_Tupla is record
      Nombre    : Unbounded_String;
      Prioridad : Integer;
   end record;

   Max_Acciones : constant Integer := 3;
   type Acciones_Array is array (1 .. Max_Acciones) of Accion_Tupla;

   protected type Acciones_Protegidas is
      procedure Guardar(Acciones : in Acciones_Array);
      procedure Obtener(Acciones : out Acciones_Array);
      procedure Resetear;
   private
      Internas : Acciones_Array := (others => (To_Unbounded_String("Esperar"), 0));
   end Acciones_Protegidas;

   protected body Acciones_Protegidas is
      procedure Guardar(Acciones : in Acciones_Array) is
      begin
         Internas := Acciones;
      end Guardar;

      procedure Obtener(Acciones : out Acciones_Array) is
         Temp : Acciones_Array := Internas;
         Tmp  : Accion_Tupla;
      begin
         for I in Temp'First .. Temp'Last - 1 loop
            for J in I + 1 .. Temp'Last loop
               if Temp(J).Prioridad > Temp(I).Prioridad then
                  Tmp := Temp(I);
                  Temp(I) := Temp(J);
                  Temp(J) := Tmp;
               end if;
            end loop;
         end loop;
         Acciones := Temp;
      end Obtener;

      procedure Resetear is
      begin
         for I in Internas'Range loop
            Internas(I) := (To_Unbounded_String("Esperar"), 0);
         end loop;
      end Resetear;
   end Acciones_Protegidas;

   protected type Estado_Giro_Protegido is
      procedure Registrar_Giro;
      procedure Resetear;
   private
      Contador : Integer := 0;
   end Estado_Giro_Protegido;

   protected body Estado_Giro_Protegido is
      procedure Registrar_Giro is
      begin
         Contador := Contador + 1;
         if Contador >= 4 then
            Put_Line("Alarma: Robot encerrado, 4 giros consecutivos.");
         end if;
      end Registrar_Giro;

      procedure Resetear is
      begin
         Contador := 0;
      end Resetear;
   end Estado_Giro_Protegido;

   Acc : aliased Acciones_Protegidas;
   Giro_Estado : aliased Estado_Giro_Protegido;

   task type Planificador(Acc : access Acciones_Protegidas) is
      entry Planear(Estado : in Estado_Tipo);
   end Planificador;

   task body Planificador is
      Estado_Actual : Estado_Tipo;
      Acciones : Acciones_Array := (others => (To_Unbounded_String("Esperar"), 0));
   begin
      loop
         accept Planear(Estado : in Estado_Tipo) do
            Estado_Actual := Estado;
            Put_Line("Planeando...");
            for I in Acciones'Range loop
               Acciones(I) := (To_Unbounded_String("Esperar"), 0);
            end loop;
            if Estado_Actual.Bateria_Baja then
               Acciones(1) := (To_Unbounded_String("Cargar"), 3);
            end if;
            if Estado_Actual.Hay_Obstaculo then
               Acciones(2) := (To_Unbounded_String("Girar"), 2);
            end if;
            if Estado_Actual.Camino_Libre and not Estado_Actual.Hay_Obstaculo then
               Acciones(3) := (To_Unbounded_String("Avanzar"), 1);
            end if;
            Acc.all.Guardar(Acciones);
         end Planear;
      end loop;
   end Planificador;

   P : Planificador(Acc'Access);

   task Avanzar is
      pragma Priority(10);
      entry Ejecutar;
   end Avanzar;

   task body Avanzar is
   begin
      loop
         accept Ejecutar do
            delay 1.0;
            Put_Line("Ejecutando: Avanzar");
            delay 1.0;
         end Ejecutar;
      end loop;
   end Avanzar;

   task Girar is
      pragma Priority(20);
      entry Ejecutar;
   end Girar;

   task body Girar is
   begin
      loop
         accept Ejecutar do
            delay 1.0;
            Put_Line("Ejecutando: Girar");
            Giro_Estado.Registrar_Giro;
            delay 1.0;
         end Ejecutar;
      end loop;
   end Girar;

   task Cargar is
      pragma Priority(30);
      entry Ejecutar;
   end Cargar;

   task body Cargar is
   begin
      loop
         accept Ejecutar do
            delay 1.0;
            Put_Line("Ejecutando: Cargar");
            delay 1.0;
         end Ejecutar;
      end loop;
   end Cargar;

   task Robot;
   task body Robot is
      Estado : Estado_Tipo;
      Acciones : Acciones_Array;
   begin
      -- Forzar 4 giros consecutivos para disparar la alarma
      for I in 1 .. 4 loop
         declare
            V : Integer := 0; -- Forzamos siempre obstáculo para provocar giros consecutivos
         begin
            case V is
               when 0 => Estado := (True, False, False);
               when 1 => Estado := (False, True, False);
               when 2 => Estado := (False, False, True);
               when others => Estado := (True, True, True);
            end case;
         end;
         Put_Line("Detectando estado...");
         Put_Line(" Obstáculo: " & Boolean'Image(Estado.Hay_Obstaculo));
         Put_Line(" Camino libre: " & Boolean'Image(Estado.Camino_Libre));
         Put_Line(" Batería baja: " & Boolean'Image(Estado.Bateria_Baja));
         P.Planear(Estado);
         delay 0.5;
         Acc.Obtener(Acciones);

         for I in Acciones'Range loop
            declare
               Nombre : constant String := To_String(Acciones(I).Nombre);
            begin
               exit when Nombre = "Esperar";
               Put_Line("Ejecutando acción: " & Nombre);
               if Nombre = "Avanzar" then
                  Avanzar.Ejecutar;
                  Giro_Estado.Resetear;
               elsif Nombre = "Girar" then
                  Girar.Ejecutar;
               elsif Nombre = "Cargar" then
                  Cargar.Ejecutar;
                  Giro_Estado.Resetear;
               end if;
            end;
         end loop;

         Acc.Resetear;
         delay 0.5;
      end loop;
   end Robot;

begin
   null;
end Robot;
