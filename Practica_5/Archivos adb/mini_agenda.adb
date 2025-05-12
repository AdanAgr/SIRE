with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Mini_Agenda is

   -- Definimos el tipo Contacto
   type Contacto is record
      Nombre   : String(1 .. 30);
      Telefono : String(1 .. 15);
      Email    : String(1 .. 30);
   end record;

   -- Máximo número de contactos
   Max_Contactos : constant := 10;

   -- Array de contactos
   type Agenda_Array is array(1 .. Max_Contactos) of Contacto;
   Agenda : Agenda_Array;
   Total  : Integer := 0;

   -- Quitar los huecos en blanco
   procedure Limpiar_String(S : in out String; Last : Natural) is
   begin
      for I in Last + 1 .. S'Last loop
         S(I) := ' ';
      end loop;
   end Limpiar_String;

   -- Añadir contactos
   procedure Anadir_Contacto is
      Nuevo : Contacto;
      Last  : Natural;
   begin
      if Total < Max_Contactos then
         Put_Line("Ingrese nombre (máx 30 caracteres): ");
         Get_Line(Nuevo.Nombre, Last);
         Limpiar_String(Nuevo.Nombre, Last);

         Put_Line("Ingrese teléfono (máx 15 caracteres): ");
         Get_Line(Nuevo.Telefono, Last);
         Limpiar_String(Nuevo.Telefono, Last);

         Put_Line("Ingrese email (máx 30 caracteres): ");
         Get_Line(Nuevo.Email, Last);
         Limpiar_String(Nuevo.Email, Last);

         Total := Total + 1;
         Agenda(Total) := Nuevo;
         Put_Line("Contacto añadido correctamente.");
      else
         Put_Line("La agenda está llena.");
      end if;
   end Anadir_Contacto;

   -- Buscar contactos (Por nombre)
   procedure Buscar_Contacto is
      Buscado    : String(1 .. 30);
      Last       : Natural;
      Encontrado : Boolean := False;
   begin
      Put_Line("Ingrese el nombre a buscar: ");
      Get_Line(Buscado, Last);
      Limpiar_String(Buscado, Last);

      for I in 1 .. Total loop
         if Agenda(I).Nombre(1 .. Last) = Buscado(1 .. Last) then
            Put_Line("Contacto encontrado:");
            Put_Line("Nombre   : " & Agenda(I).Nombre);
            Put_Line("Teléfono : " & Agenda(I).Telefono);
            Put_Line("Email    : " & Agenda(I).Email);
            Encontrado := True;
            exit;
         end if;
      end loop;

      if not Encontrado then
         Put_Line("No se encontró el contacto.");
      end if;
   end Buscar_Contacto;

   -- Mostrar Contactos
   procedure Mostrar_Contactos is
   begin
      if Total = 0 then
         Put_Line("La agenda está vacía.");
      else
         for I in 1 .. Total loop
            Put_Line("Contacto " & Integer'Image(I) & ":");
            Put_Line("  Nombre   : " & Agenda(I).Nombre);
            Put_Line("  Teléfono : " & Agenda(I).Telefono);
            Put_Line("  Email    : " & Agenda(I).Email);
         end loop;
      end if;
   end Mostrar_Contactos;

   -- Menu Principal
   procedure Menu is
      Opcion : Integer;
   begin
      loop
         Put_Line("----- Mini Agenda -----");
         Put_Line("1. Añadir contacto");
         Put_Line("2. Buscar contacto por nombre");
         Put_Line("3. Mostrar todos los contactos");
         Put_Line("4. Salir");
         Put("Seleccione una opción: ");
         Get(Opcion);
         Skip_Line; -- Sin esta linea al añadir no pide el nombre

         case Opcion is
            when 1 => Anadir_Contacto;
            when 2 => Buscar_Contacto;
            when 3 => Mostrar_Contactos;
            when 4 =>
               Put_Line("Saliendo del programa.");
               exit;
            when others =>
               Put_Line("Opción inválida.");
         end case;
      end loop;
   end Menu;

begin
   Menu;
end Mini_Agenda;
