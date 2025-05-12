with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
package body Banco is
   task body Banco_Tipo is
      Max_Cuentas : constant Integer := 10;
      type Lista_Cuentas is array (1..Max_Cuentas) of Cuenta_Bancaria;
      Cuentas : Lista_Cuentas;
      Total : Integer := 0;
   begin
      loop
         select
            accept Agregar_Cuenta(C : Cuenta_Bancaria) do
               if Total < Max_Cuentas then
                  Total := Total + 1;
                  Cuentas(Total) := C;
                  Put_Line("Cuenta agregada: " & Obtener_Titular(C));
               else
                  Put_Line("Error: límite de cuentas alcanzado");
               end if;
            end Agregar_Cuenta;
         or
            accept Transferir(Origen, Destino : String; Monto : Float) do
               declare
                  From_Idx, To_Idx : Integer := 0;
               begin
                  for I in 1 .. Total loop
                     if Obtener_Titular(Cuentas(I)) = Origen then
                        From_Idx := I;
                     elsif Obtener_Titular(Cuentas(I)) = Destino then
                        To_Idx := I;
                     end if;
                  end loop;

                  if From_Idx = 0 or To_Idx = 0 then
                     Put_Line("Error en transferencia: titulares no encontrados");
                  else
                     Retirar(Cuentas(From_Idx), Monto);
                     Depositar(Cuentas(To_Idx), Monto);
                     Put_Line("Transferencia realizada de " & Origen & " a " & Destino);
                  end if;
               end;
            end Transferir;
         or
            accept Depositar(Titular : String; Monto : Float) do
               for I in 1 .. Total loop
                  if Obtener_Titular(Cuentas(I)) = Titular then
                     Depositar(Cuentas(I), Monto);
                     Put_Line("Depósito de" & Float'Image(Monto) & " a " & Titular);
                  end if;
               end loop;
            end Depositar;
         or
            accept Retirar(Titular : String; Monto : Float) do
               for I in 1 .. Total loop
                  if Obtener_Titular(Cuentas(I)) = Titular then
                     begin
                        Retirar(Cuentas(I), Monto);
                        Put_Line("Retiro de" & Float'Image(Monto) & " a " & Titular);
                     exception
                        when Constraint_Error =>
                           Put_Line("Error: saldo insuficiente para retirar de " & Titular);
                     end;
                  end if;
               end loop;
            end Retirar;
         or
            accept Consultar_Saldo_Cuenta(Titular : String; Saldo : out Float) do
               for I in 1 .. Total loop
                  if Obtener_Titular(Cuentas(I)) = Titular then
                     Saldo := Consultar_Saldo(Cuentas(I));
                     Put_Line("Saldo de " & Titular & ": " & Float'Image(Saldo));
                  end if;
               end loop;
            end Consultar_Saldo_Cuenta;
         or
            accept Consultar_Saldo_Banco(Saldo_Total : out Float) do
               Saldo_Total := 0.0;
               for I in 1 .. Total loop
                  Saldo_Total := Saldo_Total + Consultar_Saldo(Cuentas(I));
               end loop;
               Put_Line("Saldo total banco: " & Float'Image(Saldo_Total));
            end Consultar_Saldo_Banco;
         end select;
      end loop;
   end Banco_Tipo;
end Banco;
