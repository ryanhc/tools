# %%

from datetime import datetime
import requests
import pandas as pd
import matplotlib.pyplot as plt


def main():
    # 1. CNN API 데이터 호출
    url = "https://production.dataviz.cnn.io/index/fearandgreed/graphdata"
    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"}
    response = requests.get(url, headers=headers)
    data = response.json()

    # 2. 1년 치 과거 데이터 추출 및 DataFrame 변환
    historical_data = data["fear_and_greed_historical"]["data"]
    df = pd.DataFrame(historical_data)

    # 날짜 인덱스 설정
    df["date"] = pd.to_datetime(df["x"], unit="ms")
    df.set_index("date", inplace=True)

    # 20/50일 이동평균선 계산
    df["MA20"] = df["y"].rolling(window=20).mean()
    df["MA50"] = df["y"].rolling(window=50).mean()
    df["MA120"] = df["y"].rolling(window=120).mean()

    plt.rc("font", size=16)
    plt.figure(figsize=(12, 6))

    # 원본 지수 선
    plt.plot(df.index, df["y"], color="royalblue", linewidth=1.5, alpha=0.8, label="Daily Index")
    # 20/50일 이동평균선 추가
    plt.plot(df.index, df["MA20"], color="darkorange", linewidth=1.5, alpha=0.5, label="20-Day Moving Avg")
    plt.plot(df.index, df["MA50"], color="darkgreen", linewidth=1.5, alpha=0.5, label="50-Day Moving Avg")
    plt.plot(df.index, df["MA120"], color="darkmagenta", linewidth=1.5, alpha=0.5, label="120-Day Moving Avg")

    # 각 상태별 임계치 가이드라인 추가
    plt.axhline(y=25, color="darkred", linestyle="--", alpha=0.4)
    plt.axhline(y=45, color="red", linestyle="--", alpha=0.4)
    plt.axhline(y=55, color="grey", linestyle="--", alpha=0.4)
    plt.axhline(y=75, color="green", linestyle="--", alpha=0.4)

    # 텍스트로 구간 설명 추가
    last_date = df.index[-1]
    plt.text(last_date, 12.5, " Extreme Fear", color="darkred", verticalalignment="center")
    plt.text(last_date, 35, " Fear", color="red", verticalalignment="center")
    plt.text(last_date, 50, " Neutral", color="grey", verticalalignment="center")
    plt.text(last_date, 65, " Greed", color="green", verticalalignment="center")
    plt.text(last_date, 87.5, " Extreme Greed", color="darkgreen", verticalalignment="center")

    # 가장 최근 날짜의 정보만 추가로 출력
    today = datetime.today().strftime('%Y-%m-%d %H:%M:%S')
    last_row = df.iloc[-1]
    xpos = int(len(df) / 3) if int(len(df) / 3) >= 20 else int(len(df) / 3)
    ypos = 95

    plt.text(
        df.index[xpos],
        ypos,
        f"* Date: {last_row.name.date()}\n* Generated: {today}\n* Score: {int(last_row['y'])}\n* Rating: {last_row['rating']}",
        verticalalignment="center",
    )

    # 그래프 꾸미기
    plt.title("CNN Fear & Greed Index")
    plt.xlabel("Date")
    plt.ylabel("Index Score")
    plt.ylim(0, 110)
    plt.legend(loc="upper left")
    plt.grid(True, alpha=0.3)

    plt.tight_layout()
    plt.savefig("fear_and_greed_index.png", dpi=300, bbox_inches="tight")
    #print("그래프가 'fear_and_greed_index.png' 파일로 성공적으로 저장되었습니다.")
    plt.show()


if __name__ == "__main__":
    main()
