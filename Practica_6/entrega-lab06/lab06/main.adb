with Ada.Text_IO;              use Ada.Text_IO;
with Ada.Float_Text_IO;        use Ada.Float_Text_IO;
with Ada.Integer_Text_IO;      use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;    use Ada.Strings.Unbounded;
with Cuenta;                   use Cuenta;
with Banco;                    use Banco;

procedure Main is
   B : Banco_Tipo;
   C : Cuenta_Bancaria;
   Nombre, Origen, Destino : Unbounded_String;
   Buffer : String(1..100);
   Last : Natural;
   Saldo, Monto : Float;
   Opcion : Integer;
begin
   B := Crear_Banco;

   loop
      Put_Line("====== Menú Banco ======");
      Put_Line("1. Crear cuenta");
      Put_Line("2. Depositar");
      Put_Line("3. Retirar");
      Put_Line("4. Consultar saldo de cuenta");
      Put_Line("5. Transferir");
      Put_Line("6. Consultar saldo total del banco");
      Put_Line("0. Salir");
      Put("Seleccione una opción: ");
      Ada.Integer_Text_IO.Get(Opcion);
      Skip_Line;

      case Opcion is
         when 1 =>
            Put("Nombre del titular: ");
            Get_Line(Buffer, Last);
            Nombre := To_Unbounded_String(Buffer(1..Last));
            Put("Saldo inicial: ");
            Ada.Float_Text_IO.Get(Saldo);
            Skip_Line;
            C := Crear(To_String(Nombre), Saldo);
            Agregar_Cuenta(B, C);
            Put_Line("Cuenta creada correctamente.");

         when 2 =>
            Put("Titular de la cuenta: ");
            Get_Line(Buffer, Last);
            Nombre := To_Unbounded_String(Buffer(1..Last));
            C := Consultar_Cuenta(B, To_String(Nombre));
            Put("Monto a depositar: ");
            Ada.Float_Text_IO.Get(Monto);
            Skip_Line;
            Depositar(C, Monto);
            Actualizar_Cuenta(B, C);  -- ¡GUARDA CAMBIOS!
            Put_Line("Depósito realizado.");

         when 3 =>
            Put("Titular de la cuenta: ");
            Get_Line(Buffer, Last);
            Nombre := To_Unbounded_String(Buffer(1..Last));
            C := Consultar_Cuenta(B, To_String(Nombre));
            Put("Monto a retirar: ");
            Ada.Float_Text_IO.Get(Monto);
            Skip_Line;
            begin
               Retirar(C, Monto);
               Actualizar_Cuenta(B, C);  -- ¡GUARDA CAMBIOS!
               Put_Line("Retiro realizado.");
            exception
               when Constraint_Error =>
                  Put_Line("Error: Saldo insuficiente.");
            end;

         when 4 =>
            Put("Titular de la cuenta: ");
            Get_Line(Buffer, Last);
            Nombre := To_Unbounded_String(Buffer(1..Last));
            C := Consultar_Cuenta(B, To_String(Nombre));
            Put_Line("Saldo: " & Float'Image(Consultar_Saldo(C)));

         when 5 =>
            Put("Cuenta origen: ");
            Get_Line(Buffer, Last);
            Origen := To_Unbounded_String(Buffer(1..Last));
            Put("Cuenta destino: ");
            Get_Line(Buffer, Last);
            Destino := To_Unbounded_String(Buffer(1..Last));
            Put("Monto a transferir: ");
            Ada.Float_Text_IO.Get(Monto);
            Skip_Line;
            begin
               Transferir(B, To_String(Origen), To_String(Destino), Monto);
               Put_Line("Transferencia realizada.");
            exception
               when Constraint_Error =>
                  Put_Line("Error: Transferencia no válida (saldo insuficiente o cuenta no encontrada).");
            end;

         when 6 =>
            Put_Line("Saldo total del banco: " & Float'Image(Consultar_Saldo_Banco(B)));

         when 0 =>
            exit;

         when others =>
            Put_Line("Opción no válida.");
      end case;
   end loop;
end Main;
