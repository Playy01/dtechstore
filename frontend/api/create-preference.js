// Serverless function para crear preferencia de Mercado Pago
export default async function handler(req, res) {
  // Solo permitir POST
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { items, payer, external_reference } = req.body;

    // Validar datos
    if (!items || !Array.isArray(items) || items.length === 0) {
      return res.status(400).json({ error: 'Items requeridos' });
    }

    if (!payer || !payer.email) {
      return res.status(400).json({ error: 'Datos del pagador requeridos' });
    }

    // Crear preferencia en Mercado Pago
    const preferenceData = {
      items: items,
      payer: payer,
      back_urls: {
        success: `${req.headers.origin || 'https://dtechstore.vercel.app'}/pago/success`,
        failure: `${req.headers.origin || 'https://dtechstore.vercel.app'}/pago/failure`,
        pending: `${req.headers.origin || 'https://dtechstore.vercel.app'}/pago/pending`
      },
      auto_return: 'approved',
      external_reference: external_reference,
      statement_descriptor: 'BANANATECH',
      notification_url: `${req.headers.origin || 'https://dtechstore.vercel.app'}/api/webhook`
    };

    console.log('Creando preferencia:', preferenceData);

    const response = await fetch('https://api.mercadopago.com/checkout/preferences', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer APP_USR-1919914501360405-120217-8e05bd957a1480145ee685540aacb19e-3035330195'
      },
      body: JSON.stringify(preferenceData)
    });

    const data = await response.json();

    if (!response.ok) {
      console.error('Error de Mercado Pago:', data);
      return res.status(response.status).json({ 
        error: 'Error al crear preferencia',
        details: data 
      });
    }

    console.log('Preferencia creada exitosamente:', data.id);

    // Devolver la URL de pago
    return res.status(200).json({
      id: data.id,
      init_point: data.init_point,
      sandbox_init_point: data.sandbox_init_point
    });

  } catch (error) {
    console.error('Error en create-preference:', error);
    return res.status(500).json({ 
      error: 'Error interno del servidor',
      message: error.message 
    });
  }
}
