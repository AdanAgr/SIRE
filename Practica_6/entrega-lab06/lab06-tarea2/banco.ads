with Cuenta; use Cuenta;

package Banco is
   task type Banco_Tipo is
      entry Agregar_Cuenta(C : Cuenta_Bancaria);
      entry Transferir(Origen, Destino : String; Monto : Float);
      entry Depositar(Titular : String; Monto : Float);
      entry Retirar(Titular : String; Monto : Float);
      entry Consultar_Saldo_Cuenta(Titular : String; Saldo : out Float);
      entry Consultar_Saldo_Banco(Saldo_Total : out Float);
   end Banco_Tipo;
end Banco;
