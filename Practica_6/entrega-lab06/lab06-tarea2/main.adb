with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Banco; use Banco;
with Cuenta; use Cuenta;

procedure Main is
   Banco_Instancia : Banco_Tipo;

   procedure Mostrar_Menu is
   begin
      Put_Line("---------------------------");
      Put_Line("1. Transferir dinero");
      Put_Line("2. Depositar dinero");
      Put_Line("3. Retirar dinero");
      Put_Line("4. Consultar saldo de una cuenta");
      Put_Line("5. Consultar saldo total del banco");
      Put_Line("---------------------------");
      Put("Elige una opción: ");
   end Mostrar_Menu;

   -- Definimos tareas que ejecutan operaciones concurrentes
   task type Tarea_Transferir;
   task body Tarea_Transferir is
      Origen, Destino : String(1..100);
      Last_Origen, Last_Destino : Natural;
      Monto : Float;
   begin
      Put("Introduce titular origen: ");
      Get_Line(Origen, Last_Origen);
      Put("Introduce titular destino: ");
      Get_Line(Destino, Last_Destino);
      Put("Introduce monto a transferir: ");
      Get(Monto);
      Skip_Line;
      Banco_Instancia.Transferir(Origen(1..Last_Origen), Destino(1..Last_Destino), Monto);
   end Tarea_Transferir;

   task type Tarea_Depositar;
   task body Tarea_Depositar is
      Titular : String(1..100);
      Last_Titular : Natural;
      Monto : Float;
   begin
      Put("Introduce titular para depósito: ");
      Get_Line(Titular, Last_Titular);
      Put("Introduce monto a depositar: ");
      Get(Monto);
      Skip_Line;
      Banco_Instancia.Depositar(Titular(1..Last_Titular), Monto);
   end Tarea_Depositar;

   task type Tarea_Retirar;
   task body Tarea_Retirar is
      Titular : String(1..100);
      Last_Titular : Natural;
      Monto : Float;
   begin
      Put("Introduce titular para retiro: ");
      Get_Line(Titular, Last_Titular);
      Put("Introduce monto a retirar: ");
      Get(Monto);
      Skip_Line;
      Banco_Instancia.Retirar(Titular(1..Last_Titular), Monto);
   end Tarea_Retirar;

   -- Variables del menú
   Opcion : Integer;

begin
   -- Crear banco y cuentas iniciales
   Banco_Instancia.Agregar_Cuenta(Crear("Alice", 1000.0));
   Banco_Instancia.Agregar_Cuenta(Crear("Bob", 500.0));
   Banco_Instancia.Agregar_Cuenta(Crear("Charlie", 200.0));

   -- Bucle principal
   loop
      Mostrar_Menu;
      Get(Opcion);
      Skip_Line;

      case Opcion is
         when 1 =>
            declare
               T : Tarea_Transferir;
            begin
               null;
            end;

         when 2 =>
            declare
               T : Tarea_Depositar;
            begin
               null;
            end;

         when 3 =>
            declare
               T : Tarea_Retirar;
            begin
               null;
            end;

         when 4 =>
            declare
               Titular : String(1..100);
               Last_Titular : Natural;
               Saldo : Float;
            begin
               Put("Introduce titular para consultar saldo: ");
               Get_Line(Titular, Last_Titular);
               Banco_Instancia.Consultar_Saldo_Cuenta(Titular(1..Last_Titular), Saldo);
            end;

         when 5 =>
            declare
               Saldo_Total : Float;
            begin
               Banco_Instancia.Consultar_Saldo_Banco(Saldo_Total);
            end;

         when others =>
            Put_Line("Opción no válida. Inténtalo de nuevo.");
      end case;
   end loop;
end Main;
