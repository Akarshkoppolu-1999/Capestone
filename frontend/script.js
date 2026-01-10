document.addEventListener('DOMContentLoaded', () => {
    const backendStatus = document.getElementById('backend-status');
    const dbStatus = document.getElementById('db-status');
    const refreshBtn = document.getElementById('refresh-btn');

    async function checkStatus() {
        backendStatus.textContent = 'Checking...';
        backendStatus.className = 'badge loading';
        dbStatus.textContent = 'Checking...';
        dbStatus.className = 'badge loading';

        try {
            // Updated to be relative URL for Docker/Nginx setup
            const response = await fetch('/api/status');
            const data = await response.json();

            backendStatus.textContent = data.status;
            backendStatus.className = 'badge online';

            dbStatus.textContent = data.database;
            dbStatus.className = data.database === 'Connected' ? 'badge online' : 'badge offline';
        } catch (error) {
            console.error('Error fetching status:', error);
            backendStatus.textContent = 'Offline';
            backendStatus.className = 'badge offline';
            dbStatus.textContent = 'Unknown';
            dbStatus.className = 'badge offline';
        }
    }

    refreshBtn.addEventListener('click', checkStatus);

    // Initial check
    checkStatus();
});
