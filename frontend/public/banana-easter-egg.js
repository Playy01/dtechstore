// Easter Egg: Banana
console.log('🍌 Banana Easter Egg script loaded');

function initBananaEasterEgg() {
  const searchInput = document.getElementById('searchInput');
  const searchBtn = document.querySelector('.search-btn');
  
  if (!searchInput || !searchBtn) {
    console.warn('Search elements not found');
    return;
  }
  
  console.log('🍌 Easter egg initialized');
  
  function showBananaEasterEgg() {
    console.log('🍌 Showing banana easter egg!');
    
    const overlay = document.createElement('div');
    overlay.id = 'banana-easter-egg';
    overlay.innerHTML = `
      <div class="banana-container">
        <div class="banana-giant">🍌</div>
        <div class="banana-text">¡Encontraste el secreto de BananaTech!</div>
        <button class="banana-close">Cerrar</button>
      </div>
    `;
    
    // Add styles if not already present
    if (!document.getElementById('banana-easter-egg-styles')) {
      const style = document.createElement('style');
      style.id = 'banana-easter-egg-styles';
      style.textContent = `
        #banana-easter-egg {
          position: fixed;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          background: rgba(0, 0, 0, 0.85);
          backdrop-filter: blur(10px);
          display: flex;
          align-items: center;
          justify-content: center;
          z-index: 10000;
          opacity: 0;
          transition: opacity 0.3s ease;
        }

        #banana-easter-egg.show {
          opacity: 1;
        }

        .banana-container {
          text-align: center;
          animation: bananaAppear 0.6s cubic-bezier(0.34, 1.56, 0.64, 1);
        }

        .banana-giant {
          font-size: 200px;
          animation: bananaRotate 3s ease-in-out infinite, bananaBounce 1s ease-in-out infinite;
          filter: drop-shadow(0 20px 40px rgba(255, 217, 61, 0.5));
          margin-bottom: 30px;
        }

        .banana-text {
          font-size: 32px;
          font-weight: 800;
          background: linear-gradient(135deg, #FFD93D 0%, #FFA500 100%);
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
          background-clip: text;
          margin-bottom: 30px;
          animation: textGlow 2s ease-in-out infinite;
        }

        .banana-close {
          padding: 16px 48px;
          font-size: 18px;
          font-weight: 700;
          background: linear-gradient(135deg, #FFD93D 0%, #FFA500 100%);
          color: #000;
          border: none;
          border-radius: 50px;
          cursor: pointer;
          transition: all 0.3s ease;
          box-shadow: 0 8px 24px rgba(255, 217, 61, 0.4);
        }

        .banana-close:hover {
          transform: translateY(-3px) scale(1.05);
          box-shadow: 0 12px 32px rgba(255, 217, 61, 0.6);
        }

        @keyframes bananaAppear {
          0% {
            transform: scale(0) rotate(-180deg);
            opacity: 0;
          }
          100% {
            transform: scale(1) rotate(0deg);
            opacity: 1;
          }
        }

        @keyframes bananaRotate {
          0%, 100% {
            transform: rotate(-5deg);
          }
          50% {
            transform: rotate(5deg);
          }
        }

        @keyframes bananaBounce {
          0%, 100% {
            transform: translateY(0);
          }
          50% {
            transform: translateY(-20px);
          }
        }

        @keyframes textGlow {
          0%, 100% {
            filter: drop-shadow(0 0 10px rgba(255, 217, 61, 0.5));
          }
          50% {
            filter: drop-shadow(0 0 20px rgba(255, 217, 61, 0.8));
          }
        }

        @media (max-width: 768px) {
          .banana-giant {
            font-size: 150px;
          }
          .banana-text {
            font-size: 24px;
            padding: 0 20px;
          }
          .banana-close {
            padding: 12px 36px;
            font-size: 16px;
          }
        }

        @media (max-width: 480px) {
          .banana-giant {
            font-size: 120px;
          }
          .banana-text {
            font-size: 20px;
            padding: 0 15px;
          }
          .banana-close {
            padding: 10px 30px;
            font-size: 14px;
          }
        }
      `;
      document.head.appendChild(style);
    }
    
    document.body.appendChild(overlay);
    
    setTimeout(() => overlay.classList.add('show'), 10);
    
    const closeBtn = overlay.querySelector('.banana-close');
    closeBtn.addEventListener('click', () => {
      overlay.classList.remove('show');
      setTimeout(() => overlay.remove(), 300);
    });
    
    overlay.addEventListener('click', (e) => {
      if (e.target === overlay) {
        overlay.classList.remove('show');
        setTimeout(() => overlay.remove(), 300);
      }
    });
  }
  
  // Store original search handler
  const originalSearchHandler = window.performSearch;
  
  // Create new search handler
  window.performSearch = function() {
    const query = searchInput.value.trim();
    console.log('🔍 Search query:', query);
    
    // Easter egg check
    if (query.toLowerCase() === 'banana') {
      showBananaEasterEgg();
      searchInput.value = '';
      return;
    }
    
    // Original search behavior
    if (query) {
      window.location.href = `/productos?search=${encodeURIComponent(query)}`;
    }
  };
  
  // Add event listeners
  searchBtn.addEventListener('click', window.performSearch);
  searchInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') {
      window.performSearch();
    }
  });
}

// Initialize when DOM is ready
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initBananaEasterEgg);
} else {
  initBananaEasterEgg();
}
