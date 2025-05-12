with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Cuenta is
   function Crear(Titular : String; Saldo_Inicial : Float) return Cuenta_Bancaria is
      C : Cuenta_Bancaria;
   begin
      C.Titular := To_Unbounded_String(Titular);
      C.Saldo := Saldo_Inicial;
      return C;
   end Crear;

   procedure Depositar(C : in out Cuenta_Bancaria; Monto : Float) is
   begin
      C.Saldo := C.Saldo + Monto;
   end Depositar;

   procedure Retirar(C : in out Cuenta_Bancaria; Monto : Float) is
   begin
      if C.Saldo >= Monto then
         C.Saldo := C.Saldo - Monto;
      else
         raise Constraint_Error with "Saldo insuficiente";
      end if;
   end Retirar;

   function Consultar_Saldo(C : Cuenta_Bancaria) return Float is
   begin
      return C.Saldo;
   end Consultar_Saldo;

   function Obtener_Titular(C : Cuenta_Bancaria) return String is
   begin
      return To_String(C.Titular);
   end Obtener_Titular;
end Cuenta;
