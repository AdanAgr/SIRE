with Ada.Text_IO; use Ada.Text_IO;
package body Banco is
   function Crear_Banco return Banco_Tipo is
      B : Banco_Tipo;
   begin
      return B;
   end Crear_Banco;

   procedure Agregar_Cuenta(B : in out Banco_Tipo; C : Cuenta_Bancaria) is
   begin
      if B.Total >= Max_Cuentas then
         raise Constraint_Error with "Límite de cuentas alcanzado";
      end if;
      B.Total := B.Total + 1;
      B.Cuentas(B.Total) := C;
   end Agregar_Cuenta;

   procedure Actualizar_Cuenta(B : in out Banco_Tipo; C : Cuenta_Bancaria) is
   begin
      for I in 1 .. B.Total loop
         if Obtener_Titular(B.Cuentas(I)) = Obtener_Titular(C) then
            B.Cuentas(I) := C;
            return;
         end if;
      end loop;
      raise Constraint_Error with "Cuenta no encontrada para actualizar.";
   end Actualizar_Cuenta;


   procedure Transferir(B : in out Banco_Tipo; Origen, Destino : String; Monto : Float) is
      From_Idx, To_Idx : Integer := 0;
   begin
      for I in 1 .. B.Total loop
         if Obtener_Titular(B.Cuentas(I)) = Origen then
            From_Idx := I;
         elsif Obtener_Titular(B.Cuentas(I)) = Destino then
            To_Idx := I;
         end if;
      end loop;

      if From_Idx = 0 or To_Idx = 0 then
         raise Constraint_Error with "Titulares no encontrados";
      end if;

      Retirar(B.Cuentas(From_Idx), Monto);
      Depositar(B.Cuentas(To_Idx), Monto);
   end Transferir;

   function Consultar_Cuenta(B : Banco_Tipo; Titular : String) return Cuenta_Bancaria is
   begin
      for I in 1 .. B.Total loop
         if Obtener_Titular(B.Cuentas(I)) = Titular then
            return B.Cuentas(I);
         end if;
      end loop;
      raise Constraint_Error with "Cuenta no encontrada";
   end Consultar_Cuenta;

   function Consultar_Saldo_Banco(B : Banco_Tipo) return Float is
      Total : Float := 0.0;
   begin
      for I in 1 .. B.Total loop
         Total := Total + Consultar_Saldo(B.Cuentas(I));
      end loop;
      return Total;
   end Consultar_Saldo_Banco;
end Banco;
