package model.VO;

/**
 * Clase que representa un atributo en particular de un producto.
 * Esta clase almacena la información relacionada con un atributo específico de un producto.
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosona Hernando
 * @author Pablo Pina Gracia
 */
public class AtributosVO {

    private int idAtributo; // Identificador del atributo
    private int producto; // Identificador del producto al que pertenece el atributo
    private int atributoTipo; // Identificador del tipo de atributo
    private String valorAtributo; // Valor del atributo

    /**
     * Constructor de la clase AtributosVO.
     * 
     * @param idAtributo    Identificador del atributo
     * @param producto      Identificador del producto al que pertenece el atributo
     * @param atributoTipo  Identificador del tipo de atributo
     * @param valorAtributo Valor del atributo
     */
    public AtributosVO(int idAtributo, int producto, int atributoTipo, String valorAtributo) {
        this.idAtributo = idAtributo;
        this.producto = producto;
        this.atributoTipo = atributoTipo;
        this.valorAtributo = valorAtributo;
    }

    public AtributosVO() {
		// TODO Auto-generated constructor stub
	}

	/**
     * Obtiene el identificador del atributo.
     * 
     * @return El identificador del atributo
     */
    public int getIdAtributo() {
        return idAtributo;
    }

    /**
     * Establece el identificador del atributo.
     * 
     * @param idAtributo El identificador del atributo a establecer
     */
    public void setIdAtributo(int idAtributo) {
        this.idAtributo = idAtributo;
    }

    /**
     * Obtiene el identificador del producto al que pertenece el atributo.
     * 
     * @return El identificador del producto
     */
    public int getProducto() {
        return producto;
    }

    /**
     * Establece el identificador del producto al que pertenece el atributo.
     * 
     * @param producto El identificador del producto a establecer
     */
    public void setProducto(int producto) {
        this.producto = producto;
    }

    /**
     * Obtiene el identificador del tipo de atributo.
     * 
     * @return El identificador del tipo de atributo
     */
    public int getAtributoTipo() {
        return atributoTipo;
    }

    /**
     * Establece el identificador del tipo de atributo.
     * 
     * @param atributoTipo El identificador del tipo de atributo a establecer
     */
    public void setAtributoTipo(int atributoTipo) {
        this.atributoTipo = atributoTipo;
    }

    /**
     * Obtiene el valor del atributo.
     * 
     * @return El valor del atributo
     */
    public String getValorAtributo() {
        return valorAtributo;
    }

    /**
     * Establece el valor del atributo.
     * 
     * @param valorAtributo El valor del atributo a establecer
     */
    public void setValorAtributo(String valorAtributo) {
        this.valorAtributo = valorAtributo;
    }
}
