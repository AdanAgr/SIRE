with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Cuenta is
   type Cuenta_Bancaria is private;

   function Crear(Titular : String; Saldo_Inicial : Float) return Cuenta_Bancaria;
   procedure Depositar(C : in out Cuenta_Bancaria; Monto : Float);
   procedure Retirar(C : in out Cuenta_Bancaria; Monto : Float);
   function Consultar_Saldo(C : Cuenta_Bancaria) return Float;
   function Obtener_Titular(C : Cuenta_Bancaria) return String;

private
   type Cuenta_Bancaria is record
      Titular : Unbounded_String;
      Saldo   : Float := 0.0;
   end record;
end Cuenta;
