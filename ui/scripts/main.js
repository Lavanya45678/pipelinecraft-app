document.addEventListener("DOMContentLoaded", async () => {
    console.log("PipelineCraft UI is ready!");

    // Define the backend API URL (Update with Minikube IP)
    const API_URL = "http://192.168.49.2:31587"; // Change this if your Minikube IP is different

    try {
        // Test API Call
        const response = await fetch(`${API_URL}/api/test`);
        const data = await response.json();
        
        console.log("Backend Response:", data);
    } catch (error) {
        console.error("Error connecting to backend:", error);
    }
});
