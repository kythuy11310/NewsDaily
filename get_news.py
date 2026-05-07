import requests
import json

def fetch_business_news():
    # 1. Cấu hình thông số
    url = "https://newsapi.org/v2/top-headlines"
    params = {
        "country": "us",
        "category": "business",
        "apiKey": "248fb002ea004756a3b7f56ac366008c" # Thay bằng Key mới nếu bạn đã reset
    }

    try:
        # 2. Gửi yêu cầu GET
        response = requests.get(url, params=params)
        
        # Kiểm tra nếu lỗi (ví dụ 401, 404, 500)
        response.raise_for_status()

        # 3. Chuyển đổi dữ liệu sang dạng JSON (Dictionary trong Python)
        data = response.json()

        # 4. Hiển thị dữ liệu đẹp mắt
        print(f"--- Tìm thấy {data['totalResults']} tin tức mới nhất ---\n")
        
        for article in data['articles'][:5]:  # Lấy thử 5 bài đầu tiên
            print(f"Tiêu đề: {article['title']}")
            print(f"Nguồn: {article['source']['name']}")
            print(f"Link: {article['url']}")
            print("-" * 30)

    except requests.exceptions.RequestException as e:
        print(f"Có lỗi xảy ra: {e}")

if __name__ == "__main__":
    fetch_business_news()
    